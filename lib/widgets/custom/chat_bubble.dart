// Chat message bubble with alignment and colour based on its sender.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Displays the supplied message as a user or assistant bubble.
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, required this.isUser});
  final String text;
  final bool isUser;
  @override
  Widget build(BuildContext context) => Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,

    child: Container(
      constraints: const BoxConstraints(
        maxWidth: AppSpacing.chatBubbleMaxWidth,
      ),
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        color: isUser ? AppColors.primary : AppColors.white,

        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          color: isUser ? AppColors.white : AppColors.textPrimary,
        ),
      ),
    ),
  );
}
