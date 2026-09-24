import 'package:boobook_admin/app/features/main/view/dashboard.dart';
import 'package:boobook_admin/app/features/user/providers/user_providers.dart';
import 'package:boobook_admin/app/features/user/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  static const routeName = '/main';
  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

// 2. extend [ConsumerState]
class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(appUserProvider);
    return userProvider.when(
      data: (user) => const Dashborad(),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const LoginView(),
    );
  }
}
