import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';
import '../widgets/progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final date = DateFormat.MMMMEEEEd(state.lang).format(DateTime.now());

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.greeting('TH'),
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xl),
          ProgressCard(
            learned: state.learnedToday,
            goal: state.dailyGoal,
            onContinue: () {
              // Sẽ nối sang màn Flashcard ở bước sau.
            },
          ),
          const SizedBox(height: AppSpacing.xl),

          // Danh sách tạm, sẽ thay bằng WordSetCard ở Phần 2.
          Text(
            l10n.wordSetsTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final set in state.sets) ...[
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(AppSpacing.lg),
                leading: Icon(set.icon, color: set.color),
                title: Text(
                  set.name(state.lang),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  l10n.wordsCount(set.totalCount),
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}