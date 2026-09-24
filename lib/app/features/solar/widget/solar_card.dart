import 'package:boobook_admin/app/core/utils/date_utils.dart';
import 'package:boobook_admin/app/features/solar/model/solar.dart';
import 'package:boobook_admin/app/features/solar/providers/solar_providers.dart';
import 'package:boobook_admin/app/features/solar/widget/edit_solar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SolarCardWidget extends ConsumerWidget {
  const SolarCardWidget({required this.day, super.key});
  final Solar day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              '${day.date.dateFormat} ${day.date.weekdayLabel}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              day.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            SelectableText(
              day.description ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('確認刪除'),
                            content: const Text('確定要刪除這個節氣嗎？'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('取消'),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              TextButton(
                                child: const Text('刪除'),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      ).then((confirmed) async {
                        if (confirmed ?? false) {
                          if (day.id case final int id) {
                            final ok = await ref
                                .read(solarsProvider.notifier)
                                .destroy(id);
                            if (!ok) EasyLoading.showError('刪除失敗');
                          }
                        }
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditSolarDialog(day: day);
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}