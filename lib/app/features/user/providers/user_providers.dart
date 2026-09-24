// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:boobook_admin/app/features/user/repository/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/user.dart';
part 'user_providers.g.dart';

@riverpod
class AppUser extends _$AppUser {
  @override
  Future<User?> build() async {
    final repository = ref.read(userRepositoryProvider);
    User? user = await repository.getUserInfo();

    return user;
  }

  Future<String?> login(String phone, String password) async {
    final repository = ref.read(userRepositoryProvider);
    try {
      final user = await repository.login(phone, password);
      state = AsyncValue.data(user);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
      return err.toString();
    }
    return null;
  }

  // Add methods to mutate the state
}
