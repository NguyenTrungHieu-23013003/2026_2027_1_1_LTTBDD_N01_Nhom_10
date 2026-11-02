import 'package:flutter/material.dart';

import 'word.dart';

class WordSet {
  final String id;
  final String nameVi;
  final String nameEn;
  final IconData icon;
  final Color color;
  final List<Word> words;

  WordSet({
    required this.id,
    required this.nameVi,
    required this.nameEn,
    required this.icon,
    required this.color,
    required this.words,
  });

  String name(String languageCode) => languageCode == 'vi' ? nameVi : nameEn;

  int get totalCount => words.length;
  int get learnedCount => words.where((w) => w.isLearned).length;
  double get progress => totalCount == 0 ? 0 : learnedCount / totalCount;
}