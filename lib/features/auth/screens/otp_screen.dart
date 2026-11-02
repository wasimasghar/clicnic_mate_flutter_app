// Phone verification screen for the account creation flow.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/custom/otp_input_row.dart';

/// Four digit verification form for the supplied phone number.
class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.onVerify,
    required this.onResend,
    this.isLoading = false,
  });
  final String phoneNumber;
  final ValueChanged<String> onVerify;
  final VoidCallback onResend;
  final bool isLoading;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

/// Owns OTP text controllers and focus nodes.
class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> nodes = List.generate(4, (_) => FocusNode());
  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final node in nodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xxxLarge),
            Text(AppStrings.otpTitle, style: AppTextStyles.headingLarge),
            const SizedBox(height: AppSpacing.small),
            Text(
              '${AppStrings.otpSubtitle} ${widget.phoneNumber}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: AppSpacing.xxxLarge),
            OtpInputRow(controllers: controllers, focusNodes: nodes),
            const SizedBox(height: AppSpacing.xxLarge),
            PrimaryButton(
              label: AppStrings.verifyCreateAccount,
              onPressed: () => widget.onVerify(
                controllers.map((controller) => controller.text).join(),
              ),
              isLoading: widget.isLoading,
            ),
            Center(
              child: TextButton(
                onPressed: widget.onResend,
                child: Text(
                  AppStrings.resendCode,
                  style: AppTextStyles.sectionAction,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
