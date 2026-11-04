import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';

/// Trạng thái của một đáp án trong câu hỏi.
enum AnswerState { idle, correct, wrong, disabled }

/// Nút đáp án: ô chữ cái A/B/C/D, nội dung, và biểu tượng đúng/sai.
class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.letter,
    required this.text,
    required this.state,
    this.onTap,
  });

  final String letter;
  final String text;
  final AnswerState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color border;
    final Color textColor;
    final Color badgeBackground;
    final Color badgeText;

    switch (state) {
      case AnswerState.correct:
        background = AppColors.success.withValues(alpha: 0.1);
        border = AppColors.success;
        textColor = AppColors.success;
        badgeBackground = AppColors.success;
        badgeText = Colors.white;
      case AnswerState.wrong:
        background = AppColors.error.withValues(alpha: 0.1);
        border = AppColors.error;
        textColor = AppColors.error;
        badgeBackground = AppColors.error;
        badgeText = Colors.white;
      case AnswerState.disabled:
        background = AppColors.surface;
        border = AppColors.border;
        textColor = AppColors.textSecondary;
        badgeBackground = AppColors.background;
        badgeText = AppColors.textSecondary;
      case AnswerState.idle:
        background = AppColors.surface;
        border = AppColors.border;
        textColor = AppColors.textPrimary;
        badgeBackground = AppColors.primaryLight;
        badgeText = AppColors.primary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: border, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.button),
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minHeight: 56),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: badgeBackground,
                    borderRadius: BorderRadius.circular(AppRadius.chip),
                  ),
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: badgeText,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ),
                if (state == AnswerState.correct)
                  const Icon(Icons.check_rounded, color: AppColors.success),
                if (state == AnswerState.wrong)
                  const Icon(Icons.close_rounded, color: AppColors.error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
