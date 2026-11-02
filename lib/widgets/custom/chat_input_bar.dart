// Rounded chat composer with a send action that can be disabled.
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Message input field and circular send button.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.isSending = false,
    this.onChanged,
  });
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isSending;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: TextField(
          controller: controller,

          onChanged: onChanged,
          style: AppTextStyles.bodySmall,
          decoration: InputDecoration(
            hintText: AppStrings.chatHint,

            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.large,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      const SizedBox(width: AppSpacing.small),
      IconButton.filled(
        onPressed: isSending ? null : onSend,
        style: IconButton.styleFrom(
          backgroundColor: AppColors.primary,

          foregroundColor: AppColors.white,
        ),
        icon: const Icon(Icons.send),
      ),
    ],
  );
}
