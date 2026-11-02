// ClinicMate landing screen with specialties, appointments, and assistant entry.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_card.dart';
import '../../../widgets/common/app_search_bar.dart';
import '../../../widgets/common/empty_state_view.dart';
import '../../../widgets/common/error_state_view.dart';
import '../../../widgets/common/loading_view.dart';
import '../../../widgets/common/screen_title_bar.dart';
import '../../../widgets/common/section_header.dart';
import '../../../widgets/custom/notification_bell.dart';
import '../../../widgets/custom/specialty_tile.dart';

/// Home dashboard whose specialty content comes from the caller.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.specialtyNames,
    required this.specialtyIcons,
    required this.onOpenSearch,
    required this.onOpenAssistant,
    this.onOpenAppointment,
    this.hasUpcomingAppointment = false,
    this.onOpenNotifications,
    this.onOpenProfile,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });
  final List<String> specialtyNames;
  final List<IconData> specialtyIcons;
  final VoidCallback onOpenSearch, onOpenAssistant;
  final VoidCallback? onOpenAppointment,
      onOpenNotifications,
      onOpenProfile,
      onRetry;
  final bool hasUpcomingAppointment, isLoading;
  final String? errorMessage;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        children: [
          ScreenTitleBar(
            title: AppStrings.findYourDoctor,
            trailing: [
              NotificationBell(onTap: onOpenNotifications ?? () {}),
              GestureDetector(
                onTap: onOpenProfile,
                child: const CircleAvatar(
                  backgroundColor: AppColors.primaryLight,

                  child: Icon(Icons.person_outline, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.large),
          AppSearchBar(
            hint: AppStrings.searchHint,
            readOnly: true,
            onTap: onOpenSearch,
          ),
          const SizedBox(height: AppSpacing.xxLarge),
          const SectionHeader(title: AppStrings.specialties),
          const SizedBox(height: AppSpacing.large),
          if (isLoading)
            const LoadingView()
          else if (errorMessage != null)
            ErrorStateView(message: errorMessage!, onRetry: onRetry ?? () {})
          else if (specialtyNames.isEmpty)
            const EmptyStateView(
              icon: Icons.medical_services_outlined,

              title: AppStrings.emptySpecialtiesTitle,
              message: AppStrings.emptySpecialtiesMessage,
            )
          else
            GridView.builder(
              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),
              itemCount: specialtyNames.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: AppSpacing.specialtyTileAspectRatio,
                crossAxisSpacing: AppSpacing.medium,
                mainAxisSpacing: AppSpacing.medium,
              ),
              itemBuilder: (context, index) => SpecialtyTile(
                name: specialtyNames[index],
                icon: specialtyIcons[index],
                onTap: onOpenSearch,
              ),
            ),
          const SizedBox(height: AppSpacing.xxLarge),
          const SectionHeader(title: AppStrings.upcomingAppointment),
          const SizedBox(height: AppSpacing.medium),
          hasUpcomingAppointment
              ? AppCard(
                  onTap: onOpenAppointment,

                  child: Text(
                    AppStrings.upcomingAppointment,
                    style: AppTextStyles.body,
                  ),
                )
              : Text(
                  AppStrings.noUpcomingAppointment,

                  style: AppTextStyles.caption,
                ),
          const SizedBox(height: AppSpacing.large),
          AppCard(
            onTap: onOpenAssistant,
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.primary),
                const SizedBox(width: AppSpacing.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.askAssistant,
                        style: AppTextStyles.sectionTitle,
                      ),
                      Text(
                        AppStrings.askAssistantSubtitle,
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
