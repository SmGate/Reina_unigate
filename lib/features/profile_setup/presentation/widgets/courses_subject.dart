import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_textfield.dart';

class CoursesAndSubjectSection extends StatefulWidget {
  const CoursesAndSubjectSection({super.key, this.onChanged});

  final ValueChanged<Set<String>>? onChanged;

  @override
  State<CoursesAndSubjectSection> createState() =>
      _CoursesAndSubjectSectionState();
}

class _CoursesAndSubjectSectionState extends State<CoursesAndSubjectSection> {
  final TextEditingController searchController = TextEditingController();

  final List<String> allCourses = [
    'Computer Science',
    'Software Engineering',
    'Information Technology',
    'Artificial Intelligence',
    'Data Science',
    'Cyber Security',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Civil Engineering',
    'Architecture',
    'Business Administration (BBA)',
    'MBA',
    'Accounting and Finance',
    'Economics',
    'Psychology',
    'Sociology',
    'Mass Communication',
    'English Literature',
    'Law (LLB)',
    'Pharmacy (Pharm-D)',
    'MBBS (Medicine)',
    'Dentistry (BDS)',
    'Nursing',
    'Education (B.Ed)',
    'Physics',
    'Mathematics',
    'Statistics',
    'Chemistry',
    'Biotechnology',
    'Zoology',
    'Botany',
    'Islamic Studies',
    'Urdu',
    'Political Science',
    'International Relations',
    'Environmental Science',
    'Geography',
    'Fine Arts',
    'Media Studies',
    'History',
  ];

  List<String> filteredCourses = [];
  Set<String> selectedCourses = {};

  @override
  void initState() {
    super.initState();
    filteredCourses = List.from(allCourses);

    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredCourses = allCourses
            .where((course) => course.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  void toggleSelection(String course) {
    setState(() {
      if (selectedCourses.contains(course)) {
        selectedCourses.remove(course);
      } else {
        selectedCourses.add(course);
      }
    });
    widget.onChanged?.call(selectedCourses);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH20V20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What Are Your Dream Study Areas?",
            style: AppTextStyles.displayMediumMedium20,
          ),
          AppSpacing.height20,
          Text(
            "Tell us what you want to study. We'll show you universities offering these programs. You can choose multiple.",
            style: AppTextStyles.heading3Light,
          ),
          AppSpacing.height20,
          RoundedInputField(
            controller: searchController,
            hintText: "Search Courses/Subjects by name",
            suffix: const Icon(Icons.search),
            textStyle: AppTextStyles.heading3Light12,
          ),
          AppSpacing.height20,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: filteredCourses.map((course) {
              final isSelected = selectedCourses.contains(course);
              return InkWell(
                onTap: () => toggleSelection(course),
                borderRadius: BorderRadius.circular(300),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.oceanBlue : AppColors.white,
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.oceanBlue
                          : AppColors.neutralMid,
                    ),
                  ),
                  child: Text(
                    course,
                    style: isSelected
                        ? AppTextStyles.heading3Light
                            .copyWith(color: Colors.white)
                        : AppTextStyles.heading3Light,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
