import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_textfield.dart';

class CitieseSection extends StatefulWidget {
  const CitieseSection({super.key, this.onChanged});

  final ValueChanged<Set<String>>? onChanged;

  @override
  State<CitieseSection> createState() => _CitieseSectionState();
}

class _CitieseSectionState extends State<CitieseSection> {
  final TextEditingController searchController = TextEditingController();

  final List<String> allCities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
    'Quetta',
    'Hyderabad',
    'Sialkot',
    'Bahawalpur',
    'Gujranwala',
    'Sukkur',
    'Abbottabad',
    'Mardan',
    'Mirpur',
    'Muzaffarabad',
    'Sargodha',
    'Rahim Yar Khan',
    'Dera Ghazi Khan',
    'Larkana',
    'Okara',
    'Gujrat',
  ];

  List<String> filteredCities = [];
  Set<String> selectedCities = {}; // ✅ holds selected cities

  @override
  void initState() {
    super.initState();
    filteredCities = List.from(allCities);

    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredCities = allCities
            .where((city) => city.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  void toggleSelection(String city) {
    setState(() {
      if (selectedCities.contains(city)) {
        selectedCities.remove(city);
      } else {
        selectedCities.add(city);
      }
    });
    widget.onChanged?.call(selectedCities);
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
            "Where Would You Like to Study?",
            style: AppTextStyles.displayMediumMedium20,
          ),
          AppSpacing.height20,
          Text(
            "Select cities where you're interested in finding universities. You can choose multiple.",
            style: AppTextStyles.heading3Light,
          ),
          AppSpacing.height20,
          RoundedInputField(
            controller: searchController,
            hintText: "Search city by name",
            suffix: const Icon(Icons.search),
            textStyle: AppTextStyles.heading3Light12,
          ),
          AppSpacing.height20,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: filteredCities.map((city) {
              final isSelected = selectedCities.contains(city);
              return InkWell(
                onTap: () => toggleSelection(city),
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
                    city,
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
