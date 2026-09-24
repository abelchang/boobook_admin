import 'package:boobook_admin/app/core/widget/tiny_widget.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/providers/year_provider.dart';
import 'package:boobook_admin/app/features/holiday/view/holiday_gov.dart';
import 'package:boobook_admin/app/features/holiday/widget/edit_day_dialog.dart';
import 'package:boobook_admin/app/features/holiday/widget/holiday_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidayList extends ConsumerWidget {
  const HolidayList({super.key, required this.holidays});
  final List<Holiday> holidays;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(yearProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const EditDayDialog();
              },
            );
          },
          child: const Icon(Icons.add)),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              scrolledUnderElevation: 0,
              title: Text('$year'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                    onPressed: () =>
                        ref.read(yearProvider.notifier).decrement(),
                    icon: const Icon(Icons.arrow_back_ios)),
                const C(16),
                IconButton(
                    onPressed: () =>
                        ref.read(yearProvider.notifier).increment(),
                    icon: const Icon(Icons.arrow_forward_ios)),
                const C(16),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HolidayGov(),
                        )),
                    child: const Text('政府Api')),
                const C(16),
              ],
            ),
            if (holidays.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text('沒有資料...'),
                ),
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: HolidayCardWidget(
                      day: holidays[index],
                    ),
                  );
                },
                childCount: holidays.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
