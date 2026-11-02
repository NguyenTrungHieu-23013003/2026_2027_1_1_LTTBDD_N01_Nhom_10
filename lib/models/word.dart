class Word {
  final String id;
  final String term;
  final String phonetic;
  final String meaningVi;
  final String meaningEn;
  final String example;
  bool isLearned;
  bool isFavorite;

  Word({
    required this.id,
    required this.term,
    required this.phonetic,
    required this.meaningVi,
    required this.meaningEn,
    required this.example,
    this.isLearned = false,
    this.isFavorite = false,
  });

  /// Trả về nghĩa theo ngôn ngữ giao diện ('vi' hoặc 'en').
  String meaning(String languageCode) =>
      languageCode == 'vi' ? meaningVi : meaningEn;
}