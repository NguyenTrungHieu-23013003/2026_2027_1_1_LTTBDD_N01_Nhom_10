import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../models/word.dart';
import '../providers/app_state.dart';
import '../widgets/word_tile.dart';
import 'flashcard_screen.dart';
import 'quiz_screen.dart';

class SetDetailScreen extends StatelessWidget {
  const SetDetailScreen({super.key, required this.setId});

  final String setId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final set = state.setById(setId);

    if (set == null) return const Scaffold();

    final lang = state.lang;
    final percent = (set.progress * 100).round();
    final canQuiz = set.totalCount >= 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          set.name(lang),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              l10n.setSummary(set.totalCount, percent),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FlashcardScreen(setId: set.id),
                      ),
                    ),
                    child: Text(l10n.learnFlashcard),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton(
                    onPressed: canQuiz
                        ? () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => QuizScreen(setId: set.id),
                            ),
                          )
                        : null,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                    ),
                    child: Text(l10n.takeQuiz),
                  ),
                ),
              ],
            ),
            if (!canQuiz) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.quizNeedFourWords,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.wordListTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  l10n.wordsCount(set.totalCount),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var i = 0; i < set.words.length; i++) ...[
                    if (i > 0)
                      const Divider(height: 1, color: AppColors.border),
                    WordTile(
                      word: set.words[i],
                      languageCode: lang,
                      onTap: () => _showWordSheet(context, set.words[i], lang),
                      onToggleFavorite: () =>
                          state.toggleFavorite(set.words[i]),
                      onToggleLearned: () => state.toggleLearned(set.words[i]),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bảng trượt từ dưới lên: nghĩa đầy đủ và câu ví dụ.
void _showWordSheet(BuildContext context, Word word, String lang) {
  final l10n = AppLocalizations.of(context);

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.sheet),
      ),
    ),
    builder: (_) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word.term,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              word.phonetic,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.meaningLabel.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(word.meaning(lang), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.exampleLabel.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(word.example, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}
