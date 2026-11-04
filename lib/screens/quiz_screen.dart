import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
import '../models/word.dart';
import '../providers/app_state.dart';
import '../widgets/answer_button.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.setId});

  final String setId;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const _letters = ['A', 'B', 'C', 'D'];

  List<QuizQuestion> _questions = [];
  int _index = 0;
  int? _selected;
  int _correctCount = 0;
  final List<Word> _wrongWords = [];
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _start();
  }

  /// Tạo bộ câu hỏi mới và đặt lại điểm, đồng hồ.
  void _start() {
    final state = context.read<AppState>();
    final set = state.setById(widget.setId);

    _questions = set == null ? [] : state.generateQuiz(set);
    _index = 0;
    _selected = null;
    _correctCount = 0;
    _wrongWords.clear();
    _stopwatch
      ..reset()
      ..start();
  }

  void _select(int i) {
    if (_selected != null) return;
    final question = _questions[_index];

    setState(() {
      _selected = i;
      if (i == question.correctIndex) {
        _correctCount++;
      } else {
        _wrongWords.add(question.word);
      }
    });
  }

  Future<void> _next() async {
    if (_index < _questions.length - 1) {
      setState(() {
        _index++;
        _selected = null;
      });
      return;
    }
    await _finish();
  }

  Future<void> _finish() async {
    _stopwatch.stop();

    final navigator = Navigator.of(context);
    final state = context.read<AppState>();
    final result = QuizResult(
      setId: widget.setId,
      correct: _correctCount,
      total: _questions.length,
      duration: _stopwatch.elapsed,
      date: DateTime.now(),
      wrongWords: List<Word>.of(_wrongWords),
    );
    state.addResult(result);

    final retry = await navigator.push<bool>(
      MaterialPageRoute(builder: (_) => QuizResultScreen(result: result)),
    );

    if (!mounted) return;
    if (retry == true) {
      setState(_start);
    } else if (navigator.canPop()) {
      navigator.pop();
    }
  }

  Future<void> _confirmExit() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);

    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.quizExitTitle),
        content: Text(l10n.quizExitMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.quizExitCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.quizExitConfirm),
          ),
        ],
      ),
    );

    if (leave == true) navigator.pop();
  }

  AnswerState _stateFor(int i, QuizQuestion question) {
    if (_selected == null) return AnswerState.idle;
    if (i == question.correctIndex) return AnswerState.correct;
    if (i == _selected) return AnswerState.wrong;
    return AnswerState.disabled;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lang = context.watch<AppState>().lang;

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              l10n.quizNeedFourWords,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      );
    }

    final total = _questions.length;
    final question = _questions[_index];
    final answered = _selected != null;
    final isCorrect = _selected == question.correctIndex;
    final isLast = _index == total - 1;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _confirmExit,
          ),
          title: Text(
            l10n.quizQuestionNumber(_index + 1, total),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: (_index + 1) / total,
              minHeight: 4,
              backgroundColor: AppColors.primaryLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  Text(
                    l10n.quizChooseAnswer.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppRadius.sheet),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.quizQuestionText(question.word.term),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          question.word.phonetic,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  for (var i = 0; i < question.options.length; i++) ...[
                    AnswerButton(
                      letter: _letters[i],
                      text: question.options[i].meaning(lang),
                      state: _stateFor(i, question),
                      onTap: answered ? null : () => _select(i),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (answered) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      isCorrect ? l10n.quizCorrect : l10n.quizWrong,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isCorrect ? AppColors.success : AppColors.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.quizCorrectExplain(
                        question.word.term,
                        question.word.meaning(lang),
                      ),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: ElevatedButton(
                  onPressed: answered ? _next : null,
                  child: Text(isLast ? l10n.quizFinish : l10n.quizNext),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
