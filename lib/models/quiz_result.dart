import 'word.dart';

class QuizResult {
  final String setId;
  final int correct;
  final int total;
  final Duration duration;
  final DateTime date;
  final List<Word> wrongWords;

  QuizResult({
    required this.setId,
    required this.correct,
    required this.total,
    required this.duration,
    required this.date,
    required this.wrongWords,
  });

  int get wrong => total - correct;

  /// Điểm theo thang 10.
  double get score10 => total == 0 ? 0 : correct / total * 10;
}