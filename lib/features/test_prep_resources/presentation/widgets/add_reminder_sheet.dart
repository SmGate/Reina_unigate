import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_reminder.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/search_field.dart';

class AddReminderSheet extends StatefulWidget {
  const AddReminderSheet({super.key});

  @override
  State<AddReminderSheet> createState() => _AddReminderSheetState();
}

class _AddReminderSheetState extends State<AddReminderSheet> {
  String _test = 'IELTS';
  DateTime? _date;
  TimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text('Add Test Reminder',
                style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height12,
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Test', style: AppTextStyles.inter600Black16),
            ),
            AppSpacing.height6,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SelectablePill(
                  label: 'IELTS',
                  selected: _test == 'IELTS',
                  onTap: () => setState(() => _test = 'IELTS'),
                ),
                SelectablePill(
                  label: 'TOEFL',
                  selected: _test == 'TOEFL',
                  onTap: () => setState(() => _test = 'TOEFL'),
                ),
              ],
            ),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: DateRow(
                    label: 'Date',
                    value: _date == null ? 'Pick a date' : _fmtDate(_date!),
                    onPick: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now.add(const Duration(days: 7)),
                        firstDate: now,
                        lastDate: now.add(const Duration(days: 365)),
                      );
                      if (picked != null) setState(() => _date = picked);
                    },
                  ),
                ),
                AppSpacing.width10,
                Expanded(
                  child: DateRow(
                    label: 'Time',
                    value: _time == null ? 'Pick a time' : _fmtTime(_time!),
                    onPick: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 9, minute: 0),
                      );
                      if (picked != null) setState(() => _time = picked);
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Save',
                    onPressed: () {
                      if (_date == null || _time == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select date and time')),
                        );
                        return;
                      }
                      final dt = DateTime(
                        _date!.year,
                        _date!.month,
                        _date!.day,
                        _time!.hour,
                        _time!.minute,
                      );
                      Navigator.pop(
                          context, Reminder(test: _test, dateTime: dt));
                    },
                  ),
                ),
              ],
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}
