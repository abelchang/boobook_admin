import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/core/local_storage/app_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for initializing local storage
  await AppStorage().initAppStorage();

  runApp(
    ProviderScope(
      // Riverpod 3 預設會對非 ProviderException 的自訂例外做指數退避重試（最多 10 次）。
      // 此專案的登入/例假日 API 失敗應由使用者手動重試，故設為 null 維持與 Riverpod 2 相同的行為。
      retry: (retryCount, error) => null,
      child: App(),
    ),
  );
}
