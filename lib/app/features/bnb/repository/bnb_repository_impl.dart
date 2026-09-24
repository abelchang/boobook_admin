import 'package:boobook_admin/app/core/network_utils/api.dart';
import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bnb_repository.dart';

class BnbRepositoryImpl extends BnbRepository {
  @override
  Future<List<Bnb>> getAllBnbs() async {
    final result = await Network.instance.getData("/getAllBnbs");

    switch (result["success"]) {
      case true:
        return (result['bnbs'] as List?)
                ?.map((e) => Bnb.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
      default:
        throw Exception();
    }
  }
}

final bnbRepositoryProvider = Provider<BnbRepository>((ref) {
  return BnbRepositoryImpl();
});
