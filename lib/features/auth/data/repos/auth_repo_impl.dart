// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_ai/core/error/custom_exception.dart';
import 'package:test_ai/core/error/failure.dart';
import 'package:test_ai/core/helper/backend_endpoint.dart';
import 'package:test_ai/core/services/database_service.dart';
import 'package:test_ai/core/services/firebase_auth_services.dart';
import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/shared_pref_helper.dart';
import 'package:test_ai/features/auth/data/models/user_model.dart';
import 'package:test_ai/features/auth/domain/entites/user_entity.dart';
import 'package:test_ai/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  FirebaseAuthServices firebaseAuthServices;
  DatabaseService databaseService;
  AuthRepoImpl({
    required this.firebaseAuthServices,
    required this.databaseService,
  });
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmialAndPassword(
    String email,
    String password,
    String name,
  ) async {
    User? user;
    try {
      user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEnity = UserEntity(name: name, email: email, uId: user.uid);
      await addUserData(user: userEnity);
      return right(userEnity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      log(
        'Excepetion with Firebase in create user with emil and password${e.toString()} ',
      );
      return left(ServerFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }

  //------------------------------------
  //signin with email and password
  @override
  Future<Either<Failure, UserEntity>> signInWithEmialAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = await getUserData(uId: user.uid);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Excepetion with Firebase in sign in with emil and password${e.toString()} ',
      );
      return left(ServerFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthServices.signInWithGoogle();
      UserEntity userEntity = UserModel.fromFirebaseUser(user);

      var isUserExist = await databaseService.isDataExists(
        path: BackendEndpoint.isUserExists,
        documentId: user.uid,
      );
      if (isUserExist) {
        userEntity = await _getUpdatedSocialUserData(userEntity);
      } else {
        await addUserData(user: userEntity);
      }
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      log('Excepetion with Firebase in sign in with Google ${e.toString()} ');
      return left(ServerFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
    }
  }

  // @override
  // Future<Either<Failure, UserEntity>> signInWithFacebook() async {
  //   User? user;
  //   try {
  //     user = await firebaseAuthServices.signInWithFacebook();
  //     UserEntity userEntity = UserModel.fromFirebaseUser(user);
  //     var isUserExist = await databaseService.isDataExists(
  //       path: BackendEndpoint.isUserExists,
  //       documentId: user.uid,
  //     );
  //     if (isUserExist) {
  //       userEntity = await _getUpdatedSocialUserData(userEntity);
  //     } else {
  //       await addUserData(user: userEntity);
  //     }
  //     await saveUserData(user: userEntity);
  //     return right(userEntity);
  //   } on CustomException catch (e) {
  //     await deleteUser(user);
  //     return left(ServerFailure(e.message));
  //   } catch (e) {
  //     await deleteUser(user);
  //     log('Excepetion with Firebase in sign in with Facebook ${e.toString()} ');
  //     return left(ServerFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
  //   }
  // }

  // @override
  // Future<Either<Failure, UserEntity>> signInWithApple() async {
  //   try {
  //     var user = await firebaseAuthServices.signInWithApple();
  //     return right(UserModel.fromFirebaseUser(user));
  //   } on CustomException catch (e) {
  //     return left(ServerFailure(e.message));
  //   } catch (e) {
  //     log('Excepetion with Firebase in sign in with Apple ${e.toString()} ');
  //     return left(ServerFailure('حدث خطأ غير متوقع، حاول مرة أخرى'));
  //   }
  // }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoint.addUserData,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var data = await databaseService.getData(
      path: BackendEndpoint.getUserData,
      documentId: uId,
    );
    return UserModel.fromJson(data);
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPrefHelper.setData(kUserData, jsonData);
  }

  Future<UserEntity> _getUpdatedSocialUserData(UserEntity firebaseUser) async {
    final savedUser = await getUserData(uId: firebaseUser.uId);
    final savedImageUrl = savedUser.imageUrl ?? '';
    final firebaseImageUrl = firebaseUser.imageUrl ?? '';

    if (savedImageUrl.isEmpty && firebaseImageUrl.isNotEmpty) {
      await addUserData(user: firebaseUser);
      return firebaseUser;
    }

    return savedUser;
  }
}
