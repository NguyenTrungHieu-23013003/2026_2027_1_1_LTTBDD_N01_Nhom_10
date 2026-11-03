import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../models/word.dart';
import '../providers/app_state.dart';
import '../widgets/progress_card.dart';
import '../widgets/word_set_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    setState(() => _query = '');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final date = DateFormat.MMMMEEEEd(state.lang).format(DateTime.now());
    final searching = _query.trim().isNotEmpty;

    return SafeArea(
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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

          Visibility(
            visible: !searching,
            maintainState: true,
            child: Column(
              children: [
                ProgressCard(
                  learned: state.learnedToday,
                  goal: state.dailyGoal,
                  onContinue: () {
                    // Sẽ nối sang màn Flashcard ở bước sau.
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),

          TextField(
            controller: _controller,
            onChanged: (value) => setState(() => _query = value),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              suffixIcon: searching
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      color: AppColors.textSecondary,
                      onPressed: _clearSearch,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          if (searching)
            ..._buildResults(context, state)
          else
            ..._buildSets(context, state),
        ],
      ),
    );
  }

  List<Widget> _buildSets(BuildContext context, AppState state) {
    final l10n = AppLocalizations.of(context);

    return [
      Row(
        children: [
          Expanded(
            child: Text(
              l10n.wordSetsTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            l10n.setsCount(state.sets.length),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
      const SizedBox(height: AppSpacing.md),
      for (final set in state.sets) ...[
        WordSetCard(
          set: set,
          languageCode: state.lang,
          onTap: () {
            // Sẽ nối sang màn Chi tiết bộ từ ở bước sau.
          },
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    ];
  }

  List<Widget> _buildResults(BuildContext context, AppState state) {
    final l10n = AppLocalizations.of(context);
    final results = state.search(_query);

    if (results.isEmpty) {
      return [
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Text(
            l10n.searchNoResult,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ];
    }

    return [
      Text(
        l10n.searchResultsCount(results.length),
        style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
      ),
      const SizedBox(height: AppSpacing.md),
      for (final word in results) ...[
        _ResultTile(word: word, state: state),
        const SizedBox(height: AppSpacing.sm),
      ],
    ];
  }
}

/// Một dòng kết quả tìm kiếm: từ, phiên âm, nghĩa và tên bộ từ.
class _ResultTile extends StatelessWidget {
  const _ResultTile({required this.word, required this.state});

  final Word word;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final setName = state.setOfWord(word)?.name(state.lang) ?? '';

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                word.term,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              word.phonetic,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        subtitle: Text(
          '${word.meaning(state.lang)} · $setName',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColors.textSecondary,
        ),
        onTap: () {
          // Sẽ nối sang màn Chi tiết bộ từ ở bước sau.
        },
      ),
    );
  }
}
