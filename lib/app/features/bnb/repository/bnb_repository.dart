import 'package:boobook_admin/app/features/bnb/model/bnb.dart';

abstract class BnbRepository {
  Future<List<Bnb>> getAllBnbs();
}
