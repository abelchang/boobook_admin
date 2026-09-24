import 'package:boobook_admin/app/features/main/view/dashboard.dart';
import 'package:boobook_admin/app/features/user/providers/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.read(appUserProvider.notifier);
    return FlutterLogin(
      userType: LoginUserType.phone,
      title: 'BooBook Admin',
      logo: const AssetImage('assets/icon/start.png'),
      onLogin: (data) => appUser.login(data.name, data.password),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Dashborad(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      userValidator: (value) {
        if (value == null || value.isEmpty) {
          return 'can not empty!';
        }
        return null;
      },
    );
  }
}
