import 'package:boobook_admin/app/features/bnb/providers/bnb_providers.dart';
import 'package:boobook_admin/app/features/bnb/widget/bnb_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BnbsView extends ConsumerWidget {
  const BnbsView({super.key});

  static const routeName = '/bnbs';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bnbsDataAsync = ref.watch(bnbsProvider);
    return bnbsDataAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (bnbs) => BnbList(
        bnbs: bnbs,
      ),
    );
  }
}
