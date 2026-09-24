import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network_utils/api.dart';
import '../model/holiday.dart';
import 'holiday_repository.dart';

class HolidayRepositoryImpl extends HolidayRepository {
  @override
  Future<List<Holiday>> getHolidays(int year) async {
    final Map<String, dynamic> holidayData = {
      'thisYear': year,
    };
    final result = await Network.instance.postData(holidayData, "/getholidays");

    switch (result["success"]) {
      case true:
        return (result['holidays'] as List?)
                ?.map((e) => Holiday.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
      default:
        throw Exception();
    }
  }

  @override
  Future<Holiday> store(Holiday day) async {
    final Map<String, dynamic> holidayData = {
      'holiday': day,
    };
    final result =
        await Network.instance.postData(holidayData, "/storeHoliday");

    switch (result["success"]) {
      case true:
        return Holiday.fromJson(result['holiday']);
      default:
        throw Exception(result);
    }
  }

  @override
  Future<bool> storeList(List<Holiday> holidays) async {
    final Map<String, dynamic> holidayData = {
      'holidayList': holidays,
    };
    final result =
        await Network.instance.postData(holidayData, "/holidays/storeList");

    switch (result["success"]) {
      case true:
        return true;
      default:
        throw Exception(result);
    }
  }

  @override
  Future<bool> destroy(int id) async {
    final result = await Network.instance.deleData("/holidays/destroy/$id");

    switch (result["success"]) {
      case true:
        return true;
      default:
        throw Exception(result);
    }
  }
}

final holidayRepositoryProvider = Provider<HolidayRepository>((ref) {
  return HolidayRepositoryImpl();
});
