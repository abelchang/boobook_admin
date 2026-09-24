import 'package:boobook_admin/app/core/local_storage/app_storage.dart';
import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/user/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User?> getUserInfo() async {
    final result = await Network.instance.getData("/getUserInfo");

    switch (result["success"]) {
      case true:
        return User.fromJson(result['user']);
      default:
        throw Exception(result);
    }
  }

  @override
  Future<User?> login(String phone, String password) async {
    final Map<String, dynamic> holidayData = {
      'phone': phone,
      'password': password,
    };
    final result = await Network.instance.postData(holidayData, "/login");

    switch (result["success"]) {
      case true:
        AppStorage().putToken(result["token"]);
        return User.fromJson(result['user']);

      default:
        throw Exception(result);
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});
