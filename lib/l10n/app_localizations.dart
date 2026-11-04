import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'WordTH'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In vi, this message translates to:
  /// **'Học từ vựng mỗi ngày'**
  String get tagline;

  /// No description provided for @tabHome.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get tabHome;

  /// No description provided for @tabStats.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê'**
  String get tabStats;

  /// No description provided for @tabFavorites.
  ///
  /// In vi, this message translates to:
  /// **'Yêu thích'**
  String get tabFavorites;

  /// No description provided for @tabSettings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get tabSettings;

  /// No description provided for @greeting.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào, {name}!'**
  String greeting(String name);

  /// No description provided for @progressTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tiến độ hôm nay'**
  String get progressTitle;

  /// No description provided for @progressEncourage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đang làm rất tốt!'**
  String get progressEncourage;

  /// No description provided for @continueLearning.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục học'**
  String get continueLearning;

  /// No description provided for @wordUnit.
  ///
  /// In vi, this message translates to:
  /// **'từ'**
  String get wordUnit;

  /// No description provided for @searchHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm từ vựng...'**
  String get searchHint;

  /// No description provided for @searchNoResult.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy kết quả'**
  String get searchNoResult;

  /// No description provided for @searchResultsCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} kết quả'**
  String searchResultsCount(int count);

  /// No description provided for @setSummary.
  ///
  /// In vi, this message translates to:
  /// **'{count} từ · {percent}% đã thuộc'**
  String setSummary(int count, int percent);

  /// No description provided for @learnFlashcard.
  ///
  /// In vi, this message translates to:
  /// **'Học flashcard'**
  String get learnFlashcard;

  /// No description provided for @takeQuiz.
  ///
  /// In vi, this message translates to:
  /// **'Làm quiz'**
  String get takeQuiz;

  /// No description provided for @wordListTitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách từ'**
  String get wordListTitle;

  /// No description provided for @quizNeedFourWords.
  ///
  /// In vi, this message translates to:
  /// **'Cần ít nhất 4 từ để làm quiz'**
  String get quizNeedFourWords;

  /// No description provided for @meaningLabel.
  ///
  /// In vi, this message translates to:
  /// **'Nghĩa'**
  String get meaningLabel;

  /// No description provided for @exampleLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ'**
  String get exampleLabel;

  /// No description provided for @comingSoon.
  ///
  /// In vi, this message translates to:
  /// **'Tính năng đang được phát triển'**
  String get comingSoon;

  /// No description provided for @wordSetsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bộ từ vựng'**
  String get wordSetsTitle;

  /// No description provided for @setsCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} bộ từ'**
  String setsCount(int count);

  /// No description provided for @wordsCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} từ'**
  String wordsCount(int count);

  /// No description provided for @statsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê'**
  String get statsTitle;

  /// No description provided for @favoritesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Từ yêu thích'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có từ nào'**
  String get favoritesEmpty;

  /// No description provided for @settingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settingsTitle;

  /// No description provided for @languageTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get languageTitle;

  /// No description provided for @languageVi.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVi;

  /// No description provided for @languageEn.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get languageEn;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
