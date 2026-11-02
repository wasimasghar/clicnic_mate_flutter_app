// Doctor preview card that can be embedded in an assistant reply.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../common/app_card.dart';
import '../common/secondary_button.dart';
import 'initials_avatar.dart';

/// Compact doctor information with a profile action.
class ChatDoctorCard extends StatelessWidget {
  const ChatDoctorCard({
    super.key,
    required this.initials,
    required this.name,
    required this.specialty,
    required this.fee,
    required this.onViewProfile,
  });
  final String initials, name, specialty;
  final int fee;
  final VoidCallback onViewProfile;
  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            InitialsAvatar(
              initials: initials,
              size: AppSpacing.avatarLargeSize / 2,
            ),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.sectionTitle),
                  Text(specialty, style: AppTextStyles.caption),
                  Text(
                    '${AppStrings.rupeesPrefix}$fee',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.small),
        SecondaryButton(
          label: AppStrings.viewProfile,
          onPressed: onViewProfile,
        ),
      ],
    ),
  );
}
