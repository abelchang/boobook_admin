import 'package:boobook_admin/app/features/solar/providers/solar_providers.dart';
import 'package:boobook_admin/app/features/solar/view/solar_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SolarView extends ConsumerWidget {
  const SolarView({super.key});

  static const routeName = '/solar';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final solarsDataAsync = ref.watch(solarsProvider);
    return solarsDataAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('載入失敗：$err'),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => ref.invalidate(solarsProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('重試'),
            ),
          ],
        ),
      ),
      data: (solarsData) => SolarList(
        solars: solarsData,
      ),
    );
  }
}