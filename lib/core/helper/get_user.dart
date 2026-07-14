import 'dart:convert';

import 'package:test_ai/core/constants/constant.dart';
import 'package:test_ai/core/helper/shared_pref_helper.dart';
import 'package:test_ai/features/auth/data/models/user_model.dart';
import 'package:test_ai/features/auth/domain/entites/user_entity.dart';

UserEntity getUser() {
  final jsonString = SharedPrefHelper.getString(kUserData);

  return UserModel.fromJson(jsonDecode(jsonString));
}