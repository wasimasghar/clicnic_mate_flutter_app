// Sign in form for existing ClinicMate patients.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_text_field.dart';
import '../../../widgets/common/primary_button.dart';

/// Phone and password sign in screen.
class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.onSubmit,
    required this.onCreateAccount,
    this.phoneController,
    this.passwordController,
    this.phoneError,
    this.passwordError,
    this.isLoading = false,
  });
  final VoidCallback onSubmit, onCreateAccount;
  final TextEditingController? phoneController, passwordController;
  final String? phoneError, passwordError;
  final bool isLoading;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xxxLarge),
            Text(AppStrings.signInTitle, style: AppTextStyles.headingLarge),
            const SizedBox(height: AppSpacing.small),
            Text(AppStrings.signInSubtitle, style: AppTextStyles.bodySmall),
            const SizedBox(height: AppSpacing.xxLarge),
            AppTextField(
              label: AppStrings.phoneLabel,
              hint: AppStrings.phoneHint,
              controller: phoneController ?? TextEditingController(),

              keyboardType: TextInputType.phone,
              errorText: phoneError,
            ),
            const SizedBox(height: AppSpacing.large),
            AppTextField(
              label: AppStrings.passwordFieldLabel,

              hint: AppStrings.passwordFieldHint,
              controller: passwordController ?? TextEditingController(),

              isPassword: true,
              errorText: passwordError,
            ),
            const SizedBox(height: AppSpacing.xxLarge),

            PrimaryButton(
              label: AppStrings.signInButton,
              onPressed: onSubmit,
              isLoading: isLoading,
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: onCreateAccount,

                child: Text(
                  '${AppStrings.newHerePrefix}${AppStrings.createAccount}',
                  style: AppTextStyles.sectionAction,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.large),
          ],
        ),
      ),
    ),
  );
}
