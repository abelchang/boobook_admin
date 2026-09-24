import 'package:boobook_admin/app/core/utils/date_utils.dart';
import 'package:boobook_admin/app/features/solar/model/solar.dart';
import 'package:boobook_admin/app/features/solar/providers/solar_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EditSolarDialog extends ConsumerStatefulWidget {
  final Solar? day;

  const EditSolarDialog({super.key, this.day});

  @override
  ConsumerState<EditSolarDialog> createState() => _EditSolarDialogState();
}

class _EditSolarDialogState extends ConsumerState<EditSolarDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dateController;
  bool _saving = false;
  late Solar day;

  @override
  void initState() {
    super.initState();
    day = widget.day?.copyWith() ??
        Solar(date: DateTime.now(), name: '');

    _dateController = TextEditingController(text: day.date.dateFormat);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    try {
      final ok = await ref.read(solarsProvider.notifier).store(day);
      if (!mounted) return;
      if (ok) {
        EasyLoading.showSuccess('儲存成功');
        Navigator.of(context).pop(true);
      } else {
        EasyLoading.showError('儲存失敗');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(day.id == null ? '新增節氣' : '編輯節氣'),
      content: Form(
        key: _formKey,
        child: Column(
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
                      firstDate: DateTime(1900),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, top: 4, bottom: 8),
                child: Text(
                  '星期：${day.date.weekdayLabel}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue: day.name,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? '請輸入名稱' : null,
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
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? '儲存中...' : 'Save'),
        ),
      ],
    );
  }
}