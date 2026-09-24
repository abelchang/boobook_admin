import 'package:boobook_admin/app/core/utils/date_utils.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/providers/holiday_providers.dart';
import 'package:boobook_admin/app/features/holiday/widget/edit_day_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidayCardWidget extends ConsumerWidget {
  const HolidayCardWidget({required this.day, this.editable = true, super.key});
  final Holiday day;
  final bool editable;

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
              day.date.dateFormat,
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
            const SizedBox(height: 4),
            Text(
              '假日: ${day.isHoliday}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '時間電價假日: ${day.tep}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.orange,
              ),
            ),
            if (editable)
              Align(
                alignment: Alignment.centerRight,
                child: OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Delete'),
                              content: const Text(
                                  'Are you sure you want to delete this item?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((confirmed) {
                          if (confirmed ?? false) {
                            if (day.id case final int id) {
                              ref.read(holidaysProvider.notifier).desroy(id);
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
                            return EditDayDialog(day: day);
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
