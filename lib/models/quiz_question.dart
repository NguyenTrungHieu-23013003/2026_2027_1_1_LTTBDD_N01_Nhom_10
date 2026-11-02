import 'word.dart';

/// Một câu hỏi: chọn nghĩa đúng của [word] trong 4 đáp án.
class QuizQuestion {
  final Word word;
  final List<Word> options;
  final int correctIndex;

  QuizQuestion({
    required this.word,
    required this.options,
    required this.correctIndex,
  });
}