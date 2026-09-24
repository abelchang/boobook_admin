import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:boobook_admin/app/core/local_storage/app_storage.dart';
import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/user/repository/user_repository_impl.dart';
import 'package:boobook_admin/app/features/bnb/repository/bnb_repository_impl.dart';
import 'package:boobook_admin/app/features/orders/repository/orders_repository_impl.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/repository/holiday_repository_impl.dart';

import 'package:flutter/services.dart';

class RealHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = RealHttpOverrides();

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

  group('Backend Live API Verification via boobook_admin', () {
    test('1. HolidayRepository - getHolidays(2023)', () async {
      final repo = HolidayRepositoryImpl();
      final holidays = await repo.getHolidays(2023);
      print('Retrieved ${holidays.length} holidays for 2023.');
      expect(holidays, isNotEmpty);
      expect(holidays.first.name, isNotEmpty);
      expect(holidays.first.date, isNotNull);
    });

    test('2. UserRepository - login with test user (0933787349 / 1234)', () async {
      final repo = UserRepositoryImpl();
      final user = await repo.login('0933787349', '1234');
      expect(user, isNotNull);
      print('Logged in user: name=${user?.name}, phone=${user?.phone}, permission=${user?.permission}');
      expect(user?.phone, '0933787349');
      expect(AppStorage().getToken(), isNotNull);
    });

    test('3. UserRepository - getUserInfo with token', () async {
      final repo = UserRepositoryImpl();
      final user = await repo.getUserInfo();
      expect(user, isNotNull);
      print('User info retrieved: name=${user?.name}, id=${user?.id}');
      expect(user?.phone, '0933787349');
    });

    test('4. BnbRepository - getAllBnbs', () async {
      final repo = BnbRepositoryImpl();
      final bnbs = await repo.getAllBnbs();
      print('Retrieved ${bnbs.length} BnBs.');
      expect(bnbs, isNotEmpty);
      print('First BnB: id=${bnbs.first.id}, name=${bnbs.first.bnbName}, ordersCount=${bnbs.first.ordersCount}');
      expect(bnbs.first.bnbName, isNotEmpty);
    });

    test('5. OrdersRepository - getAllOrders for BnB 8', () async {
      final repo = OrdersRepositoryImpl();
      final orders = await repo.getAllOrders(8);
      print('Retrieved ${orders.length} orders for BnB 8.');
      if (orders.isNotEmpty) {
        final firstOrder = orders.first;
        print('First order: id=${firstOrder.id}, customerId=${firstOrder.customerId}, price=${firstOrder.price}, status=${firstOrder.orderStatusId}');
        expect(firstOrder.id, isNotNull);
      }
    });

    test('6. HolidayRepository - store and destroy test holiday', () async {
      final repo = HolidayRepositoryImpl();
      final newHoliday = Holiday(
        date: DateTime.parse('2099-12-31'),
        name: '測試迎新年',
        isHoliday: true,
        holidayCategory: '國定假日',
        description: '自動驗證建立',
      );

      final created = await repo.store(newHoliday);
      print('Created holiday id=${created.id}, name=${created.name}');
      expect(created.id, isNotNull);
      expect(created.name, '測試迎新年');

      final deleted = await repo.destroy(created.id!);
      print('Deleted holiday id=${created.id}: $deleted');
      expect(deleted, isTrue);
    });

    test('7. UserRepository - login with second test user (0919506368 / 12345678)', () async {
      final repo = UserRepositoryImpl();
      final user = await repo.login('0919506368', '12345678');
      expect(user, isNotNull);
      print('Logged in second user: name=${user?.name}, phone=${user?.phone}, permission=${user?.permission}');
      expect(user?.phone, '0919506368');
    });
  });
}
