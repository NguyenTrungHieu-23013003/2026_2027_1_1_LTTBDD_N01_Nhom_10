// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'WordTH';

  @override
  String get tagline => 'Học từ vựng mỗi ngày';

  @override
  String get tabHome => 'Trang chủ';

  @override
  String get tabStats => 'Thống kê';

  @override
  String get tabFavorites => 'Yêu thích';

  @override
  String get tabSettings => 'Cài đặt';

  @override
  String greeting(String name) {
    return 'Xin chào, $name!';
  }

  @override
  String get progressTitle => 'Tiến độ hôm nay';

  @override
  String get progressEncourage => 'Bạn đang làm rất tốt!';

  @override
  String get continueLearning => 'Tiếp tục học';

  @override
  String get wordUnit => 'từ';

  @override
  String get searchHint => 'Tìm từ vựng...';

  @override
  String get searchNoResult => 'Không tìm thấy kết quả';

  @override
  String get wordSetsTitle => 'Bộ từ vựng';

  @override
  String setsCount(int count) {
    return '$count bộ từ';
  }

  @override
  String wordsCount(int count) {
    return '$count từ';
  }

  @override
  String get statsTitle => 'Thống kê';

  @override
  String get favoritesTitle => 'Từ yêu thích';

  @override
  String get favoritesEmpty => 'Chưa có từ nào';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get languageTitle => 'Ngôn ngữ';

  @override
  String get languageVi => 'Tiếng Việt';

  @override
  String get languageEn => 'English';
}
