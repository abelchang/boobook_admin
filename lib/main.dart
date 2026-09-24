import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/core/local_storage/app_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for initializing local storage
  await AppStorage().initAppStorage();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
