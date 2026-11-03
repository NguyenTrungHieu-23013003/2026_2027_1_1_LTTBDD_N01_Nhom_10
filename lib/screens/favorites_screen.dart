import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final favorites = state.favorites;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: favorites.isEmpty
            ? Center(
                child: Text(
                  l10n.favoritesEmpty,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              )
            : ListView(
                children: [
                  Text(
                    l10n.favoritesTitle,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (final w in favorites)
                    ListTile(
                      title: Text(w.term),
                      subtitle: Text(w.meaning(state.lang)),
                    ),
                ],
              ),
      ),
    );
  }
}