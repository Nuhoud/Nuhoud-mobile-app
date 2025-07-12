import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/shared/cubits/refresh_cubit/refresh_cubit.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/filter/filter_drop_down_section.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/filter/filter_text_field_section.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/filter/skills_scetion.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/filter/sort_order_section.dart';

class FilterPageBody extends StatefulWidget {
  const FilterPageBody({super.key});

  @override
  State<FilterPageBody> createState() => _FilterPageBodyState();
}

class _FilterPageBodyState extends State<FilterPageBody> {
  late TextEditingController _locationController;
  late TextEditingController _companyController;
  late TextEditingController _minSalaryController;
  late TextEditingController _maxSalaryController;
  final List<String> jobTypeList = ['دوام كامل', 'دوام جزئي', 'تدريب', 'مستقل', 'عقد'];
  final List<String> workPlaceTypeList = ['عن بعد', 'في الشركة', 'مزيج'];
  final currencyMap = {
    'ليرة سورية': 'SYP',
    'دولار أمريكي': 'USD',
    'يورو': 'EUR',
  };
  final experienceLevelMap = {
    'مبتدئ': 'Entry Level',
    'تدريب': 'Intership',
    'متوسط الخبرة': 'Mid Level',
    'خبرة عالية': 'Senior Level',
    'موظف مشارك': 'Associate',
    'مدير': 'Director',
    'منصب تنفيذي': 'Executive',
  };
  final sortByMap = {
    'تاريخ النشر': 'postedAt',
    'تاريخ الانتهاء': 'deadline',
    'أقل راتب': 'salaryRange.min',
    'أعلى راتب': 'salaryRange.max',
    'عدد الطلبات': 'applicationsCount',
    'موقع الوظيفة': 'jobLocation',
    'مستوى الخبرة': 'experienceLevel',
  };

  @override
  void initState() {
    super.initState();
    final homeCubit = context.read<HomeCubit>();
    _locationController = TextEditingController(text: homeCubit.filterLocation);
    _companyController = TextEditingController(text: homeCubit.filterCompany);
    _minSalaryController = TextEditingController(text: homeCubit.filterMinSalary);
    _maxSalaryController = TextEditingController(text: homeCubit.filterMaxSalary);
  }

  @override
  void dispose() {
    _locationController.dispose();
    _companyController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        return BlocBuilder<RefreshCubit, RefreshState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                FilterTextFieldSection(
                  title: "موقع العمل",
                  hint: "الموقع",
                  controller: _locationController,
                  onChanged: (value) => homeCubit.filterLocation = value,
                ),
                FilterTextFieldSection(
                  title: "اسم الشركة",
                  hint: "الاسم",
                  controller: _companyController,
                  onChanged: (value) => homeCubit.filterCompany = value,
                ),
                const SkillsSection(),
                Row(
                  children: [
                    Expanded(
                      child: FilterTextFieldSection(
                        title: "الحد الأدنى للراتب",
                        hint: "الحد الأدنى",
                        keyboardType: TextInputType.number,
                        controller: _minSalaryController,
                        onChanged: (value) => homeCubit.filterMinSalary = value,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilterTextFieldSection(
                        title: "الحد الأعلى للراتب",
                        hint: "الحد الأعلى",
                        keyboardType: TextInputType.number,
                        controller: _maxSalaryController,
                        onChanged: (value) => homeCubit.filterMaxSalary = value,
                      ),
                    ),
                  ],
                ),
                FilterDropdownSection(
                  title: "العملة",
                  hint: "العملة",
                  items: currencyMap.keys.toList(),
                  value: currencyMap.entries
                      .firstWhere((e) => e.value == homeCubit.filterCurrency, orElse: () => const MapEntry('', ''))
                      .key,
                  onChanged: (value) {
                    if (value != null) {
                      homeCubit.filterCurrency = currencyMap[value]!;
                    }
                  },
                ),
                FilterDropdownSection(
                  title: "طبيعة العمل",
                  hint: "طبيعة العمل",
                  items: jobTypeList,
                  value: jobTypeList.firstWhere((e) => e == homeCubit.filterJobType, orElse: () => ''),
                  onChanged: (value) {
                    if (value != null) {
                      homeCubit.filterJobType = value;
                    }
                  },
                ),
                FilterDropdownSection(
                  title: "نوع مكان العمل",
                  hint: "نوع مكان العمل",
                  items: workPlaceTypeList,
                  value: workPlaceTypeList.firstWhere((e) => e == homeCubit.filterWorkPlaceType, orElse: () => ''),
                  onChanged: (value) {
                    if (value != null) {
                      homeCubit.filterWorkPlaceType = value;
                    }
                  },
                ),
                FilterDropdownSection(
                  title: "مستوى الخبرة",
                  hint: "مستوى الخبرة",
                  items: experienceLevelMap.keys.toList(),
                  value: experienceLevelMap.entries
                      .firstWhere((e) => e.value == homeCubit.filterExperienceLevel,
                          orElse: () => const MapEntry('', ''))
                      .key,
                  onChanged: (value) {
                    if (value != null) {
                      homeCubit.filterExperienceLevel = experienceLevelMap[value]!;
                    }
                  },
                ),
                FilterDropdownSection(
                  title: "عرض حسب",
                  hint: "اختر معيار العرض",
                  items: sortByMap.keys.toList(),
                  value: sortByMap.entries
                      .firstWhere((e) => e.value == homeCubit.filterSortBy, orElse: () => const MapEntry('', ''))
                      .key,
                  onChanged: (value) {
                    if (value != null) {
                      homeCubit.filterSortBy = sortByMap[value]!;
                    }
                  },
                ),
                const SortOrderSection(),
                const SizedBox(height: 24),
                CustomButton(
                  child: Text(
                    'بحث',
                    style: Styles.textStyle16.copyWith(color: AppColors.textWhite),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push(Routers.kFilterResultScreen);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
