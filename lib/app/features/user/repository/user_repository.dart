import 'package:boobook_admin/app/features/user/model/user.dart';

abstract class UserRepository {
  Future<User?> getUserInfo();
  Future<User?> login(String phone, String password);
}
