// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:boobook_admin/app/features/bnb/model/bnb.dart';
import 'package:boobook_admin/app/features/bnb/repository/bnb_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bnb_providers.g.dart';

@riverpod
class Bnbs extends _$Bnbs {
  @override
  Future<List<Bnb>> build() async {
    final repository = ref.read(bnbRepositoryProvider);
    final bnbs = await repository.getAllBnbs();
    return bnbs;
  }
}
