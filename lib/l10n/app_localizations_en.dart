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
  String get tapToFlip => 'Tap to flip';

  @override
  String get markNotLearned => 'Not learned yet';

  @override
  String get markLearned => 'Learned';

  @override
  String get flashcardDone => 'Set complete!';

  @override
  String flashcardDoneSub(int learned, int total) {
    return 'You learned $learned/$total words';
  }

  @override
  String get studyAgain => 'Study again';

  @override
  String get backToSet => 'Back';

  @override
  String quizQuestionNumber(int current, int total) {
    return 'Question $current/$total';
  }

  @override
  String get quizChooseAnswer => 'Choose the correct answer';

  @override
  String quizQuestionText(String word) {
    return 'What does “$word” mean?';
  }

  @override
  String get quizCorrect => 'Correct!';

  @override
  String get quizWrong => 'Not quite';

  @override
  String quizCorrectExplain(String word, String meaning) {
    return '“$word” means “$meaning”.';
  }

  @override
  String get quizNext => 'Next';

  @override
  String get quizFinish => 'See results';

  @override
  String get quizExitTitle => 'Quit the quiz?';

  @override
  String get quizExitMessage => 'This attempt will not be saved.';

  @override
  String get quizExitConfirm => 'Quit';

  @override
  String get quizExitCancel => 'Stay';

  @override
  String get resultTitle => 'Quiz complete!';

  @override
  String get resultMessageHigh => 'Excellent!';

  @override
  String get resultMessageMid => 'Nice work';

  @override
  String get resultMessageLow => 'Keep practicing';

  @override
  String get resultScoreUnit => 'points';

  @override
  String get resultCorrect => 'Correct';

  @override
  String get resultWrong => 'Wrong';

  @override
  String get resultTime => 'Time';

  @override
  String get resultReviewTitle => 'Words to review';

  @override
  String get resultPerfect => 'You got everything right!';

  @override
  String get resultRetry => 'Try again';

  @override
  String get resultHome => 'Back to home';

  @override
  String get statsSubtitle => 'Track your learning journey';

  @override
  String get statLearned => 'Words learned';

  @override
  String get statQuizzes => 'Quizzes taken';

  @override
  String get statAverage => 'Average score';

  @override
  String get chartTitle => 'Words learned per day';

  @override
  String get recentTitle => 'Recent quiz results';

  @override
  String get recentEmpty => 'No quiz results yet';

  @override
  String get weekdayLabels => 'Mon,Tue,Wed,Thu,Fri,Sat,Sun';

  @override
  String get settingsSubtitle => 'Personalize your learning';

  @override
  String get dailyGoalTitle => 'Daily goal';

  @override
  String get dailyGoalSubtitle => 'Build a steady study habit';

  @override
  String get aboutTitle => 'Team information';

  @override
  String get aboutSubtitle => 'About the WordTH project';

  @override
  String get versionLabel => 'Version';

  @override
  String get infoFullName => 'Full name';

  @override
  String get infoStudentId => 'Student ID';

  @override
  String get infoClass => 'Class';

  @override
  String get infoEmail => 'Email';

  @override
  String get projectInfoTitle => 'Project information';

  @override
  String get projectTopicLabel => 'Topic';

  @override
  String get projectTopicValue => 'Vocabulary learning app';

  @override
  String get projectCourseLabel => 'Course';

  @override
  String get projectCourseValue => 'Mobile application development';

  @override
  String get githubLabel => 'GitHub';

  @override
  String get githubOpenFailed => 'Could not open the link';

  @override
  String get membersTitle => 'Members';

  @override
  String favoritesCount(int count) {
    return '$count saved words';
  }

  @override
  String get favoritesEmptyHint =>
      'Tap the heart icon in a word list to save your favorites';

  @override
  String favoritesRemoved(String word) {
    return 'Removed “$word” from favorites';
  }

  @override
  String get undo => 'Undo';

  @override
  String get themeTitle => 'Appearance';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

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
