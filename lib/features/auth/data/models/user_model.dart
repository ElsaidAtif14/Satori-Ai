import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_ai/features/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.uId,
    super.imageUrl,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uId: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      imageUrl: user.photoURL,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      uId: json['uId'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      uId: user.uId,
      imageUrl: user.imageUrl,
    );
  }

  // ignore: strict_top_level_inference
  toMap() {
    return {'name': name, 'email': email, 'uId': uId, 'imageUrl': imageUrl};
  }
}
