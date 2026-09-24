import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network_utils/api.dart';
import '../model/solar.dart';
import 'solar_repository.dart';

class SolarRepositoryImpl extends SolarRepository {
  SolarRepositoryImpl({Network? network})
      : _network = network ?? Network.instance;

  final Network _network;

  @override
  Future<List<Solar>> getSolars(int year) async {
    final Map<String, dynamic> solarData = {
      'thisYear': year,
    };
    final result = await _network.postData(solarData, "/getsolars");

    switch (result["success"]) {
      case true:
        return (result['solars'] as List?)
                ?.map((e) => Solar.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
      default:
        throw Exception();
    }
  }

  @override
  Future<List<Solar>> generateYear(int year) async {
    final Map<String, dynamic> solarData = {
      'thisYear': year,
    };
    final result =
        await _network.postData(solarData, "/solars/generateYear");

    switch (result["success"]) {
      case true:
        return (result['solars'] as List?)
                ?.map((e) => Solar.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
      default:
        throw Exception(result);
    }
  }

  @override
  Future<Solar> store(Solar day) async {
    final Map<String, dynamic> solarData = {
      'solar': day,
    };
    final result = await _network.postData(solarData, "/storeSolar");

    switch (result["success"]) {
      case true:
        return Solar.fromJson(result['solar']);
      default:
        throw Exception(result);
    }
  }

  @override
  Future<bool> destroy(int id) async {
    final result = await _network.deleData("/solars/destroy/$id");

    switch (result["success"]) {
      case true:
        return true;
      default:
        throw Exception(result);
    }
  }
}

final solarRepositoryProvider = Provider<SolarRepository>((ref) {
  return SolarRepositoryImpl();
});