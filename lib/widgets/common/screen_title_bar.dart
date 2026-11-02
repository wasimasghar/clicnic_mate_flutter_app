// Large bold title row like "My Health", with room for a bell and avatar.

import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Top-of-screen heading with optional trailing actions on the right.
class ScreenTitleBar extends StatelessWidget {
  const ScreenTitleBar({
    super.key,
    required this.title,
    this.trailing = const [],
  });

  final String title;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.headingLarge)),
        for (final Widget action in trailing) ...[
          const SizedBox(width: AppSpacing.small),
          action,
        ],
      ],
    );
  }
}
