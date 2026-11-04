import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../models/quiz_result.dart';
import '../providers/app_state.dart';
import '../widgets/stat_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();

    final average = state.history.isEmpty
        ? '–'
        : state.averageScore.toStringAsFixed(1);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.statsTitle,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.statsSubtitle,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.menu_book_outlined,
                  color: AppColors.primary,
                  value: '${state.totalLearned}',
                  label: l10n.statLearned,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: StatCard(
                  icon: Icons.check_circle_outline,
                  color: AppColors.accent,
                  value: '${state.history.length}',
                  label: l10n.statQuizzes,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: StatCard(
                  icon: Icons.track_changes_outlined,
                  color: AppColors.success,
                  value: average,
                  label: l10n.statAverage,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _WeekChartCard(counts: state.weekStudyCounts()),
          const SizedBox(height: AppSpacing.lg),
          _RecentResultsCard(state: state),
        ],
      ),
    );
  }
}

/// Biểu đồ cột: số từ đã học mỗi ngày trong tuần hiện tại.
class _WeekChartCard extends StatelessWidget {
  const _WeekChartCard({required this.counts});

  final List<int> counts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = l10n.weekdayLabels.split(',');
    final highest = counts.fold<int>(0, (m, v) => v > m ? v : m);
    final maxY = (highest < 5 ? 5 : highest + 1).toDouble();
    final todayIndex = DateTime.now().weekday - 1;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.chartTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          final text = i >= 0 && i < labels.length
                              ? labels[i]
                              : '';
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: i == todayIndex
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: i == todayIndex
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var i = 0; i < counts.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: counts[i].toDouble(),
                            width: 22,
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                            backDrawRodData: BackgroundBarChartRodData(
                              show: true,
                              toY: maxY,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Danh sách các lần làm quiz gần đây.
class _RecentResultsCard extends StatelessWidget {
  const _RecentResultsCard({required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recent = state.history.take(5).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.recentTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (recent.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Center(
                  child: Text(
                    l10n.recentEmpty,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              )
            else
              for (var i = 0; i < recent.length; i++) ...[
                if (i > 0) const Divider(height: 1, color: AppColors.border),
                _RecentRow(result: recent[i], state: state),
              ],
          ],
        ),
      ),
    );
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow({required this.result, required this.state});

  final QuizResult result;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final lang = state.lang;
    final setName = state.setById(result.setId)?.name(lang) ?? '';
    final date = DateFormat.yMd(lang).format(result.date);

    final ratio = result.total == 0 ? 0.0 : result.correct / result.total;
    final color = ratio >= 0.8
        ? AppColors.success
        : ratio >= 0.5
        ? AppColors.primary
        : AppColors.accent;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            child: Icon(Icons.check_rounded, color: color, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  setName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '${result.correct}/${result.total}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
