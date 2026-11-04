import 'dart:math';

import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
import '../models/word.dart';
import '../models/word_set.dart';

/// Nguồn trạng thái duy nhất của ứng dụng.
class AppState extends ChangeNotifier {
  AppState() : sets = buildSampleSets();

  final List<WordSet> sets;
  final List<QuizResult> history = [];

  /// Số từ đánh dấu "đã thuộc" theo ngày, khóa dạng yyyy-MM-dd.
  final Map<String, int> studyLog = {};

  final Random _random = Random();

  Locale _locale = const Locale('vi');
  int _dailyGoal = 20;

  // ---------- Cài đặt ----------
  Locale get locale => _locale;
  String get lang => _locale.languageCode;
  int get dailyGoal => _dailyGoal;

  void setLocale(Locale locale) {
    if (locale == _locale) return;
    _locale = locale;
    notifyListeners();
  }

  void setDailyGoal(int value) {
    _dailyGoal = value.clamp(5, 50);
    notifyListeners();
  }

  // ---------- Truy vấn ----------
  List<Word> get favorites => [
    for (final s in sets) ...s.words.where((w) => w.isFavorite),
  ];

  int get totalLearned => sets.fold(0, (sum, s) => sum + s.learnedCount);

  int get learnedToday => studyLog[_dayKey(DateTime.now())] ?? 0;

  double get averageScore {
    if (history.isEmpty) return 0;
    final total = history.fold<double>(0, (sum, r) => sum + r.score10);
    return total / history.length;
  }

  /// Số từ đánh dấu đã thuộc mỗi ngày trong tuần hiện tại (thứ 2 đến chủ nhật).
  List<int> weekStudyCounts() {
    final now = DateTime.now();
    final monday = DateTime(now.year, now.month, now.day - (now.weekday - 1));
    return [
      for (var i = 0; i < 7; i++)
        studyLog[_dayKey(
              DateTime(monday.year, monday.month, monday.day + i),
            )] ??
            0,
    ];
  }

  WordSet? setById(String id) {
    for (final s in sets) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// Bộ từ chứa [word], dùng để hiện tên bộ từ trong kết quả tìm kiếm.
  WordSet? setOfWord(Word word) {
    for (final s in sets) {
      if (s.words.contains(word)) return s;
    }
    return null;
  }

  /// Tìm theo từ tiếng Anh hoặc nghĩa (cả tiếng Việt và tiếng Anh).
  List<Word> search(String keyword) {
    final q = keyword.trim().toLowerCase();
    if (q.isEmpty) return [];
    return [
      for (final s in sets)
        ...s.words.where(
          (w) =>
              w.term.toLowerCase().contains(q) ||
              w.meaningVi.toLowerCase().contains(q) ||
              w.meaningEn.toLowerCase().contains(q),
        ),
    ];
  }

  // ---------- Thao tác ----------
  void toggleFavorite(Word word) {
    word.isFavorite = !word.isFavorite;
    notifyListeners();
  }

  void toggleLearned(Word word) {
    word.isLearned = !word.isLearned;
    final key = _dayKey(DateTime.now());
    final current = studyLog[key] ?? 0;
    studyLog[key] = word.isLearned ? current + 1 : max(0, current - 1);
    notifyListeners();
  }

  /// Tạo tối đa [maxQuestions] câu hỏi. Bộ từ cần ít nhất 4 từ.
  List<QuizQuestion> generateQuiz(WordSet set, {int maxQuestions = 10}) {
    if (set.words.length < 4) return [];

    final picked = [...set.words]..shuffle(_random);
    final chosen = picked.take(min(maxQuestions, picked.length));

    return [for (final word in chosen) _buildQuestion(set, word)];
  }

  QuizQuestion _buildQuestion(WordSet set, Word word) {
    final distractors = set.words.where((w) => w.id != word.id).toList()
      ..shuffle(_random);
    final options = [word, ...distractors.take(3)]..shuffle(_random);
    return QuizQuestion(
      word: word,
      options: options,
      correctIndex: options.indexOf(word),
    );
  }

  void addResult(QuizResult result) {
    history.insert(0, result);
    notifyListeners();
  }

  static String _dayKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
