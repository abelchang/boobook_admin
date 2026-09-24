import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/main/view/main_view.dart';

///
/// for getting routers that are present in the app
///
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: MainView.routeName,
    routes: [
      /// for showing onboarding
      GoRoute(
        path: MainView.routeName,
        builder: (context, state) => const MainView(),
      ),
    ],
  );
});
