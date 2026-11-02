// Branded ClinicMate welcome splash with the existing transparent doctor image.
// StartupSplashGate automatically continues after the splash duration.

import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Welcomes patients with a clear message and ClinicMate's doctor artwork.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              AppColors.primaryLight,
            ],
            stops: [0, 0.54, 1],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compactLayout = constraints.maxHeight < 700;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.extraLarge,
                      AppSpacing.large,
                      AppSpacing.extraLarge,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.favorite_rounded,
                              color: AppColors.white,
                              size: 22,
                            ),
                            const SizedBox(width: AppSpacing.small),
                            Text(
                              AppStrings.appName,
                              style: AppTextStyles.sectionTitle.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: compactLayout ? 26 : 38),
                        Text(
                          'CARE MADE SIMPLE',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.white.withValues(alpha: 0.82),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.8,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.small),
                        Text(
                          'Find care.\nFeel better.',
                          style: AppTextStyles.headingLarge.copyWith(
                            color: AppColors.white,
                            fontSize: compactLayout ? 38 : 44,
                            height: 1.02,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.medium),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 310),
                          child: Text(
                            'Trusted doctors and easy appointments, all in one place.',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.white.withValues(alpha: 0.9),
                              height: 1.4,
                            ),
                          ),
                        ),
                        SizedBox(height: compactLayout ? 16 : 22),
                        Wrap(
                          spacing: AppSpacing.small,
                          runSpacing: AppSpacing.small,
                          children: const [
                            _SplashFeatureChip(
                              icon: Icons.verified_outlined,
                              label: 'Trusted doctors',
                            ),
                            _SplashFeatureChip(
                              icon: Icons.calendar_month_outlined,
                              label: 'Easy booking',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        AppAssets.splashDoctor,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                        width: constraints.maxWidth * 0.96,
                        height: constraints.maxHeight *
                            (compactLayout ? 0.49 : 0.55),
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.medical_services_outlined,
                          size: constraints.maxHeight * 0.28,
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Shows one short care benefit in a translucent splash chip.
class _SplashFeatureChip extends StatelessWidget {
  const _SplashFeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.small,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.32)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.white),
          const SizedBox(width: AppSpacing.extraSmall),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
