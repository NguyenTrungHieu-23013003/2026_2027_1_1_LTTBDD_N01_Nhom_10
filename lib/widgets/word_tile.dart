import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../models/word.dart';

/// Một dòng từ: từ, phiên âm, nghĩa, nút yêu thích và nút đã thuộc.
class WordTile extends StatelessWidget {
  const WordTile({
    super.key,
    required this.word,
    required this.languageCode,
    this.onTap,
    this.onToggleFavorite,
    this.onToggleLearned,
  });

  final Word word;
  final String languageCode;
  final VoidCallback? onTap;
  final VoidCallback? onToggleFavorite;
  final VoidCallback? onToggleLearned;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacing.lg,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs,
          right: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          word.term,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Flexible(
                        child: Text(
                          word.phonetic,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    word.meaning(languageCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onToggleFavorite,
              icon: Icon(
                word.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: word.isFavorite
                    ? AppColors.accent
                    : AppColors.textSecondary,
              ),
            ),
            IconButton(
              onPressed: onToggleLearned,
              icon: Icon(
                word.isLearned
                    ? Icons.check_circle_rounded
                    : Icons.check_circle_outline_rounded,
                color: word.isLearned
                    ? AppColors.success
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
