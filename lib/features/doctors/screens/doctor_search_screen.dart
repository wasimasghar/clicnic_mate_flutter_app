// Search and filter screen for doctor results.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/common/app_search_bar.dart';
import '../../../widgets/common/empty_state_view.dart';
import '../../../widgets/common/error_state_view.dart';
import '../../../widgets/common/loading_view.dart';
import '../../../widgets/custom/doctor_list_card.dart';
import '../../../widgets/custom/filter_chip_row.dart';

/// Doctor list with loading, empty, and error states.
class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({
    super.key,
    required this.initials,
    required this.doctorNames,
    required this.specialties,
    required this.ratings,
    required this.fees,
    required this.clinics,
    required this.areas,
    required this.nextTimes,
    required this.onDoctorTap,
    required this.onSearchChanged,
    required this.onRetry,
    this.isLoading = false,
    this.errorMessage,
    this.selectedFilters = const [],
    this.onFilterChanged,
    this.onSortChanged,
    this.sortValue = AppStrings.sortRelevance,
    this.emptyMessage,
  });
  final List<String> initials,
      doctorNames,
      specialties,
      ratings,
      clinics,
      areas,
      nextTimes;
  final List<int> fees;
  final ValueChanged<int> onDoctorTap;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onRetry;
  final bool isLoading;
  final String? errorMessage;
  final List<String> selectedFilters;
  final ValueChanged<String>? onFilterChanged;
  final ValueChanged<String>? onSortChanged;
  final String sortValue;
  final String? emptyMessage;

  @override
  State<DoctorSearchScreen> createState() => _DoctorSearchScreenState();
}

/// Holds current filter selection for the search screen.
class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  @override
  Widget build(BuildContext context) {
    const filters = [
      AppStrings.filterCity,
      AppStrings.filterSpecialty,
      AppStrings.filterFee,
      AppStrings.filterRating,
      AppStrings.filterFemaleDoctor,
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.extraLarge),

              child: Column(
                children: [
                  AppSearchBar(
                    hint: AppStrings.searchHint,
                    onChanged: widget.onSearchChanged,
                  ),
                  const SizedBox(height: AppSpacing.small),
                  FilterChipRow(
                    labels: filters,
                    selectedLabels: widget.selectedFilters,
                    onSelected: widget.onFilterChanged ?? (_) {},
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      const Text('${AppStrings.sortLabel}: '),
                      DropdownButton<String>(
                        value: widget.sortValue,

                        items:
                            const [
                                  AppStrings.sortRelevance,
                                  AppStrings.sortFeeLowHigh,
                                  AppStrings.sortRatingHigh,
                                ]
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) widget.onSortChanged?.call(value);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: widget.isLoading
                  ? const LoadingView()
                  : widget.errorMessage != null
                  ? ErrorStateView(
                      message: widget.errorMessage!,

                      onRetry: widget.onRetry,
                    )
                  : widget.doctorNames.isEmpty
                  ? EmptyStateView(
                      icon: Icons.search_off,

                      title: AppStrings.emptyDoctorsTitle,
                      message:
                          widget.emptyMessage ?? AppStrings.emptyDoctorsMessage,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.extraLarge),

                      itemCount: widget.doctorNames.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.medium),
                      itemBuilder: (_, index) => DoctorListCard(
                        initials: widget.initials[index],
                        name: widget.doctorNames[index],
                        specialty: widget.specialties[index],
                        rating: widget.ratings[index],
                        fee: widget.fees[index],
                        clinic: widget.clinics[index],

                        area: widget.areas[index],
                        nextTime: widget.nextTimes[index],
                        onTap: () => widget.onDoctorTap(index),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
