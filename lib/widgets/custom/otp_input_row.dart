// Four separately focusable numeric OTP entry boxes.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Four digit fields whose controllers and focus nodes belong to the screen.
class OtpInputRow extends StatelessWidget {
  const OtpInputRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      4,
      (index) => SizedBox(
        width: AppSpacing.otpBoxSize,
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: AppTextStyles.heading,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],

          decoration: const InputDecoration(
            counterText: '',
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
      ),
    ),
  );
}
