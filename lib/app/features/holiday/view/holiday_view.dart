import 'package:boobook_admin/app/features/holiday/widget/holiday_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/holiday_providers.dart';

class HolidayView extends ConsumerWidget {
  const HolidayView({super.key});

  static const routeName = '/holiday';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidaysDataAsync = ref.watch(holidaysProvider);
    return holidaysDataAsync.when(
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
              onPressed: () => ref.invalidate(holidaysProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('重試'),
            ),
          ],
        ),
      ),
      data: (holidaysData) => HolidayList(
        holidays: holidaysData,
      ),
    );
  }
}
