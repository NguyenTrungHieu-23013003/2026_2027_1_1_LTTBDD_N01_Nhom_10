import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../models/quiz_result.dart';
import '../providers/app_state.dart';

class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key, required this.result});

  final QuizResult result;

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen>
    with TickerProviderStateMixin {
  late final AnimationController _celebrationController = AnimationController(
    duration: const Duration(milliseconds: 1800),
    vsync: this,
  );
  bool _celebrationStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_celebrationStarted) return;
    _celebrationStarted = true;
    if (!MediaQuery.of(context).disableAnimations) {
      _celebrationController.forward();
    }
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = context.watch<AppState>().lang;

    final result = widget.result;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    final ratio = result.total == 0 ? 0.0 : result.correct / result.total;
    final message = ratio >= 0.8
        ? l10n.resultMessageHigh
        : ratio >= 0.5
        ? l10n.resultMessageMid
        : l10n.resultMessageLow;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    children: [
                      const SizedBox(height: AppSpacing.lg),
                      Center(
                        child: SizedBox(
                          width: 108,
                          height: 108,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(108, 108),
                                painter: _LightRaysPainter(
                                  progress: reduceMotion
                                      ? 1
                                      : _celebrationController.value,
                                ),
                              ),
                              ScaleTransition(
                                scale:
                                    Tween<double>(
                                      begin: reduceMotion ? 1 : 0.7,
                                      end: 1,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: _celebrationController,
                                        curve: const Interval(
                                          0,
                                          0.55,
                                          curve: Curves.elasticOut,
                                        ),
                                      ),
                                    ),
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent.withValues(
                                      alpha: 0.12,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.emoji_events_outlined,
                                    size: 36,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.resultTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Center(
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(
                                  begin: reduceMotion ? ratio : 0,
                                  end: ratio,
                                ),
                                duration: reduceMotion
                                    ? Duration.zero
                                    : const Duration(milliseconds: 1000),
                                curve: Curves.easeOutCubic,
                                builder: (context, animatedRatio, child) {
                                  return SizedBox.expand(
                                    child: CircularProgressIndicator(
                                      value: animatedRatio,
                                      strokeWidth: 12,
                                      strokeCap: StrokeCap.round,
                                      backgroundColor: AppColors.primaryLight,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            AppColors.primary,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              TweenAnimationBuilder<double>(
                                tween: Tween(
                                  begin: 0,
                                  end: result.correct.toDouble(),
                                ),
                                duration: reduceMotion
                                    ? Duration.zero
                                    : const Duration(milliseconds: 1000),
                                curve: Curves.easeOutCubic,
                                builder: (context, animatedCorrect, child) =>
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${animatedCorrect.round()}/${result.total}',
                                          style: const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryDark,
                                          ),
                                        ),
                                        Text(
                                          l10n.resultScoreUnit,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              icon: Icons.check_rounded,
                              color: AppColors.success,
                              value: '${result.correct}',
                              label: l10n.resultCorrect,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.close_rounded,
                              color: AppColors.error,
                              value: '${result.wrong}',
                              label: l10n.resultWrong,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _StatCard(
                              icon: Icons.schedule_rounded,
                              color: AppColors.primary,
                              value: _formatDuration(result.duration),
                              label: l10n.resultTime,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.resultReviewTitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              if (result.wrongWords.isEmpty)
                                Text(
                                  l10n.resultPerfect,
                                  style: const TextStyle(
                                    color: AppColors.success,
                                  ),
                                )
                              else
                                for (final word in result.wrongWords) ...[
                                  const Divider(color: AppColors.border),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          word.term,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.md),
                                      Flexible(
                                        child: Text(
                                          word.meaning(lang),
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(l10n.resultRetry),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).popUntil((r) => r.isFirst),
                        child: Text(
                          l10n.resultHome,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _celebrationController,
                  builder: (context, child) {
                    if (_celebrationController.value == 0 ||
                        _celebrationController.isCompleted) {
                      return const SizedBox.shrink();
                    }
                    return CustomPaint(
                      painter: _ConfettiPainter(
                        progress: _celebrationController.value,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  const _ConfettiPainter({required this.progress});

  final double progress;

  static const _colors = [
    AppColors.primary,
    AppColors.accent,
    AppColors.success,
    Color(0xFFFFC857),
    Color(0xFFB388EB),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final opacity = (1 - progress).clamp(0.0, 1.0);
    for (var i = 0; i < 48; i++) {
      final xFraction = ((i * 37) % 53) / 52;
      final startOffset = -((i * 17) % 19) / 19;
      final yFraction = progress * 1.35 + startOffset;
      if (yFraction < 0 || yFraction > 1) continue;

      final x = xFraction * size.width + math.sin(progress * 8 + i) * 18;
      final y = yFraction * size.height;
      final rotation = progress * 10 + i * 0.7;
      final paint = Paint()
        ..color = _colors[i % _colors.length].withValues(alpha: opacity);

      canvas
        ..save()
        ..translate(x, y)
        ..rotate(rotation);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: 6, height: 11),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _LightRaysPainter extends CustomPainter {
  const _LightRaysPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final opacity = (1 - progress).clamp(0.0, 1.0);
    final innerRadius = 40.0;
    final outerRadius = 48.0 + 8 * progress;
    final paint = Paint()
      ..color = AppColors.accent.withValues(alpha: opacity * 0.42);

    for (var i = 0; i < 12; i++) {
      final angle = i * math.pi / 6 + progress * 0.2;
      final path = Path()
        ..moveTo(
          center.dx + math.cos(angle) * innerRadius,
          center.dy + math.sin(angle) * innerRadius,
        )
        ..lineTo(
          center.dx + math.cos(angle - 0.08) * outerRadius,
          center.dy + math.sin(angle - 0.08) * outerRadius,
        )
        ..lineTo(
          center.dx + math.cos(angle + 0.08) * outerRadius,
          center.dy + math.sin(angle + 0.08) * outerRadius,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_LightRaysPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
