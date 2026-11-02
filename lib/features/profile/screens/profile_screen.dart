// Patient profile details and account actions.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_card.dart';
import '../../../widgets/custom/initials_avatar.dart';
import '../../../widgets/custom/profile_info_row.dart';
import '../../../widgets/custom/profile_menu_row.dart';

/// Read-only patient profile and navigation callbacks.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.initials,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.city,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.onEditProfile,
    required this.onWaitingList,
    required this.onNotifications,
    required this.onSignOut,
  });
  final String initials,
      name,
      username,
      phone,
      email,
      city,
      gender,
      dateOfBirth,
      bio;
  final VoidCallback onEditProfile, onWaitingList, onNotifications, onSignOut;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(AppStrings.profileTab)),

    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.extraLarge),
      children: [
        Center(child: InitialsAvatar(initials: initials)),
        const SizedBox(height: AppSpacing.medium),
        Text(name, style: AppTextStyles.heading, textAlign: TextAlign.center),
        Text(
          '@$username',
          style: AppTextStyles.caption,
          textAlign: TextAlign.center,
        ),
        Text(
          phone,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.large),
        AppCard(
          child: Column(
            children: [
              ProfileInfoRow(label: AppStrings.email, value: email),
              ProfileInfoRow(label: AppStrings.city, value: city),
              ProfileInfoRow(label: AppStrings.gender, value: gender),
              ProfileInfoRow(
                label: AppStrings.dateOfBirthLabel,
                value: dateOfBirth,
              ),
              ProfileInfoRow(label: AppStrings.bio, value: bio),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.large),

        AppCard(
          child: Column(
            children: [
              ProfileMenuRow(
                label: AppStrings.editProfile,
                icon: Icons.edit_outlined,
                onTap: onEditProfile,
              ),
              ProfileMenuRow(
                label: AppStrings.waitingListTitle,

                icon: Icons.hourglass_empty,
                onTap: onWaitingList,
              ),
              ProfileMenuRow(
                label: AppStrings.notifications,

                icon: Icons.notifications_none,
                onTap: onNotifications,
              ),
              ProfileMenuRow(
                label: AppStrings.signOut,
                icon: Icons.logout,
                onTap: onSignOut,
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
