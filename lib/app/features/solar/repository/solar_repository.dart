import '../model/solar.dart';

abstract class SolarRepository {
  Future<List<Solar>> getSolars(int year);
  Future<List<Solar>> generateYear(int year);
  Future<Solar> store(Solar day);
  Future<bool> destroy(int id);
}