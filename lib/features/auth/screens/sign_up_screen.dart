// Registration form for new ClinicMate patients.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_text_field.dart';
import '../../../widgets/common/primary_button.dart';

/// Patient details form with date picker and optional biography.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });
  final void Function(
    String phone,
    String username,
    String dateOfBirth,
    String? bio,
    String password,
  )
  onSubmit;
  final bool isLoading;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

/// Keeps the selected date of birth for the registration form.
class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController password = TextEditingController();
  DateTime? birthDate;
  String? usernameErrorText;
  @override
  void dispose() {
    phone.dispose();
    username.dispose();
    bio.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) setState(() => birthDate = date);
  }

  void submitSignUp() {
    final usernameValue = username.text.trim();
    final isValidUsername = RegExp(
      r'^[A-Za-z0-9_]{3,30}$',
    ).hasMatch(usernameValue);
    setState(() {
      usernameErrorText = isValidUsername
          ? null
          : AppStrings.usernameFormatError;
    });
    if (!isValidUsername || birthDate == null) return;

    widget.onSubmit(
      phone.text.trim(),
      usernameValue,
      birthDate!.toIso8601String().split('T').first,
      bio.text.trim().isEmpty ? null : bio.text.trim(),
      password.text,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.signUpTitle, style: AppTextStyles.headingLarge),
            const SizedBox(height: AppSpacing.small),
            Text(AppStrings.signUpSubtitle, style: AppTextStyles.bodySmall),
            const SizedBox(height: AppSpacing.xxLarge),
            AppTextField(
              label: AppStrings.phoneLabel,
              hint: AppStrings.phoneHint,
              controller: phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.large),
            AppTextField(
              label: AppStrings.usernameLabel,
              hint: AppStrings.usernameHint,
              controller: username,
              errorText: usernameErrorText,
              onChanged: (_) {
                if (usernameErrorText != null) {
                  setState(() => usernameErrorText = null);
                }
              },
            ),
            const SizedBox(height: AppSpacing.large),
            GestureDetector(
              onTap: selectBirthDate,
              child: AbsorbPointer(
                child: AppTextField(
                  label: AppStrings.dateOfBirthLabel,

                  hint: birthDate == null
                      ? AppStrings.dateOfBirthHint
                      : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',

                  controller: TextEditingController(
                    text: birthDate == null
                        ? ''
                        : '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}',
                  ),

                  suffixIcon: const Icon(Icons.calendar_today_outlined),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.large),
            AppTextField(
              label: AppStrings.bioLabel,
              hint: AppStrings.bioHint,
              controller: bio,
              maxLines: 4,
              maxLength: 300,
            ),
            const SizedBox(height: AppSpacing.large),
            AppTextField(
              label: AppStrings.passwordFieldLabel,

              hint: AppStrings.passwordFieldHint,
              controller: password,
              isPassword: true,
            ),
            const SizedBox(height: AppSpacing.xxLarge),
            PrimaryButton(
              label: AppStrings.sendOtp,
              isLoading: widget.isLoading,
              onPressed: birthDate == null ? null : submitSignUp,
            ),
          ],
        ),
      ),
    ),
  );
}
