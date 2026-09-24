import 'package:boobook_admin/app/core/utils/date_utils.dart';
import 'package:boobook_admin/app/features/holiday/model/holiday.dart';
import 'package:boobook_admin/app/features/holiday/providers/holiday_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EditDayDialog extends ConsumerStatefulWidget {
  final Holiday? day;

  const EditDayDialog({super.key, this.day});

  @override
  ConsumerState<EditDayDialog> createState() => _EditDayDialogState();
}

class _EditDayDialogState extends ConsumerState<EditDayDialog> {
  late TextEditingController _dateController;
  late bool _isHoliday;
  late bool _isTep;
  Holiday day = Holiday(date: DateTime.now(), name: '', isHoliday: false);

  @override
  void initState() {
    super.initState();
    if (widget.day != null) {
      day = widget.day!.copyWith();
    }

    _dateController = TextEditingController(text: day.date.dateFormat);

    _isHoliday = day.isHoliday;
    _isTep = day.tep;
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Day'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.parse(_dateController.text),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    day = day.copyWith(date: selectedDate);
                    setState(() {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
              ),
            ),
          ),
          TextFormField(
            initialValue: day.name,
            decoration: const InputDecoration(labelText: 'Name'),
            onChanged: (value) {
              setState(() {
                day = day.copyWith(name: value);
              });
            },
          ),
          TextFormField(
            initialValue: day.description,
            minLines: 1,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              setState(() {
                day = day.copyWith(description: value);
              });
            },
          ),
          CheckboxListTile(
            title: const Text('假日'),
            value: _isHoliday,
            onChanged: (value) {
              setState(() {
                _isHoliday = !_isHoliday;
                day = day.copyWith(isHoliday: _isHoliday);
              });
            },
          ),
          CheckboxListTile(
            title: const Text('時間電價假日'),
            value: _isTep,
            onChanged: (value) {
              setState(() {
                _isTep = !_isTep;
                day = day.copyWith(tep: _isTep);
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(holidaysProvider.notifier).store(day);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
