import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_ai/core/error/custom_exception.dart';

class FirebaseAuthServices {
  //Delete User
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  //-------------------------------------
  //signup with email and password
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        log(
          'FirebaseAuthException in createUserWithEmailAndPassword',
          error: '$e with code : ${e.code}',
          name: 'FirebaseAuthServices',
        );
      }

      if (e.code == 'weak-password') {
        throw CustomException('كلمة المرور ضعيفة جدًا');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('البريد الإلكتروني مستخدم بالفعل');
      } else if (e.code == 'invalid-email') {
        throw CustomException('البريد الإلكتروني غير صحيح');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
          'لا يوجد اتصال بالإنترنت، تأكد من الشبكة وحاول مرة أخرى',
        );
      } else {
        throw CustomException('حدث خطأ أثناء إنشاء الحساب');
      }
    } catch (e) {
      if (kDebugMode) {
        log(
          'FirebaseAuthException  in createUserWithEmailAndPassword',
          error: e,
          name: 'FirebaseAuthServices',
        );
      }
      throw CustomException('حدث خطأ غير متوقع، حاول مرة أخرى');
    }
  }

  //-------------------------------------
  //signin with email and password

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()} and code is ${e.code}",
      );
      if (e.code == 'user-not-found') {
        throw CustomException('الرقم السري او البريد الالكتروني غير صحيح.');
      } else if (e.code == 'wrong-password') {
        throw CustomException('الرقم السري غير صحيح.');
      } else if (e.code == 'invalid-credential') {
        throw CustomException('الرقم السري او البريد الالكتروني غير صحيح.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException('تاكد من اتصالك بالانترنت.');
      } else {
        throw CustomException('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
      }
    } catch (e) {
      log(
        "Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}",
      );

      throw CustomException('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }
  //Sign in with google

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize once (safe to call again, but ideally do this at app startup)

      await googleSignIn.initialize(
        serverClientId:
            '657046049929-ea39b9q771k42daq5h7em5o08cl9l6be.apps.googleusercontent.com',
      );

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      // idToken comes from authentication
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // accessToken now comes from the authorization client, not authentication
      final GoogleSignInClientAuthorization? authorization = await googleUser
          .authorizationClient
          .authorizationForScopes(<String>['email']);

      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      return (await FirebaseAuth.instance.signInWithCredential(
        credential,
      )).user!;
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()}");
      throw CustomException('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
    }
  }

  // //Sign in with facebook
  // Future<User> signInWithFacebook() async {
  //   try {
  //     // Trigger the sign-in flow
  //     final LoginResult loginResult = await FacebookAuth.instance.login(
  //       permissions: ['email', 'public_profile'],
  //     );

  //     if (loginResult.status == LoginStatus.success) {
  //       // Create a credential from the access token
  //       final OAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential(
  //             loginResult.accessToken!.tokenString,
  //           );

  //       // Once signed in, return the UserCredential
  //       return (await FirebaseAuth.instance.signInWithCredential(
  //         facebookAuthCredential,
  //       )).user!;
  //     } else if (loginResult.status == LoginStatus.cancelled) {
  //       throw CustomException('تم إلغاء تسجيل الدخول عبر فيسبوك');
  //     } else {
  //       throw CustomException(
  //         'فشل تسجيل الدخول عبر فيسبوك: ${loginResult.message}',
  //       );
  //     }
  //   } catch (e) {
  //     log(
  //       "Exception in FirebaseAuthService.signInWithFacebook: ${e.toString()}",
  //     );
  //     throw CustomException('لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.');
  //   }
  // }

  // //-------------------------------------
  // //sign in with apple
  // String generateNonce([int length = 32]) {
  //   final charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final random = Random.secure();
  //   return List.generate(
  //     length,
  //     (_) => charset[random.nextInt(charset.length)],
  //   ).join();
  // }

  // /// Returns the sha256 hash of [input] in hex notation.
  // String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }

  // Future<User> signInWithApple() async {
  //   final rawNonce = generateNonce();
  //   final nonce = sha256ofString(rawNonce);

  //   // Request credential for the currently signed in Apple account.
  //   final appleCredential = await SignInWithApple.getAppleIDCredential(
  //     scopes: [
  //       AppleIDAuthorizationScopes.email,
  //       AppleIDAuthorizationScopes.fullName,
  //     ],
  //     nonce: nonce,
  //   );

  //   // Create an `OAuthCredential` from the credential returned by Apple.
  //   final oauthCredential = OAuthProvider(
  //     "apple.com",
  //   ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);
  //   return (await FirebaseAuth.instance.signInWithCredential(
  //     oauthCredential,
  //   )).user!;
  // }

  bool isUserLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    try {
      // await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log("Exception in FirebaseAuthService.signOut: ${e.toString()}");
      throw CustomException('حدث خطأ أثناء تسجيل الخروج');
    }
  }
}
