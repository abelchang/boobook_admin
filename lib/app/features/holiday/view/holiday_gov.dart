import 'package:boobook_admin/app/core/widget/tiny_widget.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/providers/holiday_gov_providers.dart';
import 'package:boobook_admin/app/features/holiday/providers/holiday_providers.dart';
import 'package:boobook_admin/app/features/holiday/repository/holiday_repository_impl.dart';
import 'package:boobook_admin/app/features/holiday/widget/holiday_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 政府公開資料匯入頁：從新北市開放資料 API 抓取國定假日，依年份瀏覽並批次匯入資料庫。
class HolidayGov extends ConsumerStatefulWidget {
  const HolidayGov({super.key});

  @override
  ConsumerState<HolidayGov> createState() => _HolidayGovState();
}

class _HolidayGovState extends ConsumerState<HolidayGov> {
  /// 瀏覽用的年份（與主列表的 `yearProvider` 各自獨立，僅影響本頁過濾）。
  int _year = DateTime.now().year;
  bool _importing = false;

  @override
  Widget build(BuildContext context) {
    final govHolidaysAsync = ref.watch(govHolidaysProvider);
    final yearHolidays = govHolidaysAsync.value
            ?.where((h) => h.date.year == _year)
            .toList() ??
        const <Holiday>[];

    return Scaffold(
      appBar: AppBar(
        title: Text('$_year'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() => _year--);
            },
            icon: const Icon(Icons.remove),
          ),
          const C(16),
          IconButton(
            onPressed: () {
              setState(() => _year++);
            },
            icon: const Icon(Icons.add),
          ),
          const C(16),
          ElevatedButton(
            onPressed:
                yearHolidays.isEmpty || _importing ? null : () => _import(yearHolidays),
            child: Text(_importing ? '匯入中...' : 'import'),
          ),
          const C(16),
        ],
      ),
      body: govHolidaysAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('載入政府資料失敗：$err'),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => ref.invalidate(govHolidaysProvider),
                child: const Text('重試'),
              ),
            ],
          ),
        ),
        data: (data) => yearHolidays.isEmpty
            ? const Center(
                child: Text('該年度沒有資料...'),
              )
            : ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: yearHolidays.length,
                separatorBuilder: (BuildContext ctx, int index) {
                  return const SizedBox(height: 16);
                },
                itemBuilder: (BuildContext ctx, int index) {
                  return HolidayCardWidget(
                    editable: false,
                    day: yearHolidays[index],
                  );
                },
              ),
      ),
    );
  }

  Future<void> _import(List<Holiday> items) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認匯入'),
          content: Text('將匯入 $_year 年度共 ${items.length} 筆假日資料到資料庫，確定？'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('確認'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;

    setState(() => _importing = true);
    try {
      final ok = await ref.read(holidayRepositoryProvider).storeList(items);
      if (!mounted) return;
      if (ok) {
        EasyLoading.showSuccess('匯入完成！');
        ref.read(holidaysProvider.notifier).refresh();
        Navigator.of(context).pop();
      } else {
        EasyLoading.showError('匯入失敗！');
      }
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }
}