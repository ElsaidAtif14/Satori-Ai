import 'package:dartz/dartz.dart';
import 'package:test_ai/core/error/failure.dart';
import 'package:test_ai/features/auth/domain/entites/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmialAndPassword(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, UserEntity>> signInWithEmialAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  // Future<Either<Failure, UserEntity>> signInWithFacebook();
  // Future<Either<Failure, UserEntity>> signInWithApple();
  Future addUserData({required UserEntity user});
  Future saveUserData({required UserEntity user});
  Future<UserEntity> getUserData({required String uId});
}
