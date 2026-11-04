// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'WordTH';

  @override
  String get tagline => 'Learn vocabulary every day';

  @override
  String get tabHome => 'Home';

  @override
  String get tabStats => 'Stats';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get tabSettings => 'Settings';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get progressTitle => 'Today\'s progress';

  @override
  String get progressEncourage => 'You\'re doing great!';

  @override
  String get continueLearning => 'Continue learning';

  @override
  String get wordUnit => 'words';

  @override
  String get searchHint => 'Search vocabulary...';

  @override
  String get searchNoResult => 'No results found';

  @override
  String searchResultsCount(int count) {
    return '$count results';
  }

  @override
  String setSummary(int count, int percent) {
    return '$count words · $percent% learned';
  }

  @override
  String get learnFlashcard => 'Study flashcards';

  @override
  String get takeQuiz => 'Take quiz';

  @override
  String get wordListTitle => 'Word list';

  @override
  String get quizNeedFourWords => 'At least 4 words are needed for a quiz';

  @override
  String get meaningLabel => 'Meaning';

  @override
  String get exampleLabel => 'Example';

  @override
  String get comingSoon => 'This feature is coming soon';

  @override
  String get wordSetsTitle => 'Word sets';

  @override
  String setsCount(int count) {
    return '$count sets';
  }

  @override
  String wordsCount(int count) {
    return '$count words';
  }

  @override
  String get statsTitle => 'Statistics';

  @override
  String get favoritesTitle => 'Favorite words';

  @override
  String get favoritesEmpty => 'No words yet';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageVi => 'Tiếng Việt';

  @override
  String get languageEn => 'English';
}
