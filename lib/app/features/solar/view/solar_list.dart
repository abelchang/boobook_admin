import 'package:boobook_admin/app/core/widget/tiny_widget.dart';
import 'package:boobook_admin/app/features/solar/model/solar.dart';
import 'package:boobook_admin/app/features/solar/providers/solar_providers.dart';
import 'package:boobook_admin/app/features/solar/providers/solar_year_provider.dart';
import 'package:boobook_admin/app/features/solar/widget/edit_solar_dialog.dart';
import 'package:boobook_admin/app/features/solar/widget/solar_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SolarList extends ConsumerWidget {
  const SolarList({super.key, required this.solars});
  final List<Solar> solars;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(solarYearProvider);
    final statusLine = _statusLine(solars);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const EditSolarDialog();
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
              title: Text('節氣 $year'),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.autorenew),
                  tooltip: '產生該年節氣',
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('產生節氣'),
                        content: Text(
                          '將以天文演算法重建 $year 年的 24 個節氣，'
                          '並覆寫該年現有資料。確定？',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('取消'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('產生'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed ?? false) {
                      final ok = await ref
                          .read(solarsProvider.notifier)
                          .generateYear(year);
                      if (!context.mounted) return;
                      if (ok) {
                        EasyLoading.showSuccess('已產生 $year 年 24 個節氣');
                      } else {
                        EasyLoading.showError('產生失敗');
                      }
                    }
                  },
                ),
                IconButton(
                    onPressed: () =>
                        ref.read(solarYearProvider.notifier).decrement(),
                    icon: const Icon(Icons.arrow_back_ios)),
                const C(16),
                IconButton(
                    onPressed: () =>
                        ref.read(solarYearProvider.notifier).increment(),
                    icon: const Icon(Icons.arrow_forward_ios)),
                const C(16),
              ],
            ),
            if (statusLine != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                  child: Text(
                    statusLine,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            if (solars.isEmpty)
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
                    child: SolarCardWidget(
                      day: solars[index],
                    ),
                  );
                },
                childCount: solars.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 顯示該年節氣的資料狀態：自動產生的最後時間，或人工資料。
  static String? _statusLine(List<Solar> solars) {
    if (solars.isEmpty) {
      return '此年份還沒有節氣資料，可按右上角「產生」以天文演算法自動建立 24 個節氣。';
    }
    final generatedTimes =
        solars.map((s) => s.generatedAt).whereType<DateTime>();
    if (generatedTimes.isEmpty) {
      return '此年份為人工維護資料（無自動產生記錄）。';
    }
    final last = generatedTimes.reduce((a, b) => a.isAfter(b) ? a : b);
    return '自動產生於 ${DateFormat('yyyy-MM-dd HH:mm').format(last.toLocal())}；仍可個別手動調整。';
  }
}