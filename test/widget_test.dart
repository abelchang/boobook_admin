// Basic smoke test: verifies the app can be built and renders the initial
// screen without exceptions.
//
// The app entry (main.dart) calls AppStorage().initAppStorage() before
// runApp(), so this test initializes local storage the same way.

import 'dart:io';

import 'package:boobook_admin/app/app.dart';
import 'package:boobook_admin/app/core/local_storage/app_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('boobook_test_hive_');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async => tempDir.path,
    );
    await AppStorage().initAppStorage();
  });

  tearDownAll(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  testWidgets('App builds and renders its initial screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: App()));
    // Let the initial async providers (login check) settle into an error
    // state (no backend available in tests), which shows the LoginView.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // The root widget is mounted and the app is running.
    expect(find.byType(App), findsOneWidget);

    // Flush timers created by the login widget (e.g. its initState
    // fade-in timer) so the test ends without pending timers.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));
  });
}