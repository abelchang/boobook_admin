import '../model/holiday.dart';

abstract class HolidayRepository {
  Future<List<Holiday>> getHolidays(int year);
  Future<Holiday> store(Holiday day);
  Future<bool> storeList(List<Holiday> holidays);
  Future<bool> destroy(int id);
}
