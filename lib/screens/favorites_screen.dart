import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../models/word.dart';
import '../providers/app_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/word_tile.dart';
import 'set_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  /// Bỏ yêu thích và cho phép hoàn tác.
  void _remove(BuildContext context, AppState state, Word word) {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    state.toggleFavorite(word);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.favoritesRemoved(word.term)),
          action: SnackBarAction(
            label: l10n.undo,
            onPressed: () => state.toggleFavorite(word),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final favorites = state.favorites;

    final header = Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.favoritesTitle,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.favoritesCount(favorites.length),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );

    if (favorites.isEmpty) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            Expanded(
              child: EmptyState(
                icon: Icons.favorite_border,
                title: l10n.favoritesEmpty,
                message: l10n.favoritesEmptyHint,
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        children: [
          header,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  for (var i = 0; i < favorites.length; i++) ...[
                    if (i > 0)
                      const Divider(height: 1, color: AppColors.border),
                    Dismissible(
                      key: ValueKey(favorites[i].id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _remove(context, state, favorites[i]),
                      background: Container(
                        color: AppColors.error,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: AppSpacing.xl),
                        child: const Icon(
                          Icons.heart_broken_outlined,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: AppColors.surface,
                        child: WordTile(
                          word: favorites[i],
                          languageCode: state.lang,
                          onTap: () {
                            final wordSet = state.setOfWord(favorites[i]);
                            if (wordSet == null) return;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    SetDetailScreen(setId: wordSet.id),
                              ),
                            );
                          },
                          onToggleFavorite: () =>
                              _remove(context, state, favorites[i]),
                          onToggleLearned: () =>
                              state.toggleLearned(favorites[i]),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
