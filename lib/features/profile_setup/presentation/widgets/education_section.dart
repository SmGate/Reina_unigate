import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/profile_setup/presentation/widgets/education_card.dart';

class EducationSection extends StatefulWidget {
  const EducationSection({super.key, this.onChanged});

  final ValueChanged<int?>? onChanged;

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH20V20,
      child: Column(
        children: [
          Text(
            "What's Your Current Academic Level?",
            style: AppTextStyles.displayMediumMedium20,
          ),
          AppSpacing.height20,
          Text(
            "This helps us recommend universities and courses relevant to your qualifications.",
            style: AppTextStyles.heading3Light,
          ),
          AppSpacing.height20,
          EducationCard(
            image: AppAssets.matric,
            title: "Matriculation/O-Levels.",
            subtitle: "Completed Secondary Education.",
            isSelected: _selectedIndex == 0,
            onTap: () {
              setState(() => _selectedIndex = 0);
              widget.onChanged?.call(_selectedIndex);
            },
          ),
          AppSpacing.height20,
          EducationCard(
            image: AppAssets.intermedial,
            title: "Intermediate/A-Levels.",
            subtitle: "Completed Higher Secondary Education",
            isSelected: _selectedIndex == 1,
            onTap: () {
              setState(() => _selectedIndex = 1);
              widget.onChanged?.call(_selectedIndex);
            },
          ),
          AppSpacing.height20,
          EducationCard(
            image: AppAssets.graduation,
            title: "Bachelors Degree",
            subtitle: "Completed Undergraduate Studies",
            isSelected: _selectedIndex == 2,
            onTap: () {
              setState(() => _selectedIndex = 2);
              widget.onChanged?.call(_selectedIndex);
            },
          ),
          AppSpacing.height20,
          EducationCard(
            image: AppAssets.master,
            title: "Masters Degree",
            subtitle: "Completed Postgraduate Studies",
            isSelected: _selectedIndex == 3,
            onTap: () {
              setState(() => _selectedIndex = 3);
              widget.onChanged?.call(_selectedIndex);
            },
          ),
          AppSpacing.height20,
          EducationCard(
            image: AppAssets.other,
            title: "Other",
            subtitle: "Specify your academic qualification",
            isSelected: _selectedIndex == 4,
            onTap: () {
              setState(() => _selectedIndex = 4);
              widget.onChanged?.call(_selectedIndex);
            },
          ),
        ],
      ),
    );
  }
}
