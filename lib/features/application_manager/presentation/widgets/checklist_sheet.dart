import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/application_manager/data/model/application_models.dart';

class ChecklistSheet extends StatefulWidget {
  final ApplicationItem item;
  final VoidCallback onUpdate;
  const ChecklistSheet({super.key, required this.item, required this.onUpdate});

  @override
  State<ChecklistSheet> createState() => _ChecklistSheetState();
}

class _ChecklistSheetState extends State<ChecklistSheet> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = widget.item.tasks.map((t) => Task(t.title, t.done)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          Text('Checklist – ${widget.item.university}',
              style: AppTextStyles.displayMediumMedium18),
          AppSpacing.height12,
          ...List.generate(tasks.length, (i) {
            final t = tasks[i];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Checkbox(
                    value: t.done,
                    onChanged: (v) => setState(() => t.done = v ?? false),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  Expanded(
                    child: Text(t.title, style: AppTextStyles.inter400Black16),
                  ),
                ],
              ),
            );
          }),
          AppSpacing.height12,
          CustomButton(
            width: double.infinity,
            text: 'Save Checklist',
            onPressed: () {
              for (int i = 0; i < widget.item.tasks.length; i++) {
                widget.item.tasks[i].done = tasks[i].done;
              }
              widget.onUpdate();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Checklist saved')),
              );
            },
          ),
          AppSpacing.height8,
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: AppTextStyles.displaySmall500),
          ),
          AppSpacing.height6,
        ],
      ),
    );
  }
}
