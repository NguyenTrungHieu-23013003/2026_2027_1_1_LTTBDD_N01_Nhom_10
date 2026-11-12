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
  String searchResultsCount(int count) {
    return '$count kết quả';
  }

  @override
  String setSummary(int count, int percent) {
    return '$count từ · $percent% đã thuộc';
  }

  @override
  String get learnFlashcard => 'Học flashcard';

  @override
  String get takeQuiz => 'Làm quiz';

  @override
  String get wordListTitle => 'Danh sách từ';

  @override
  String get quizNeedFourWords => 'Cần ít nhất 4 từ để làm quiz';

  @override
  String get meaningLabel => 'Nghĩa';

  @override
  String get exampleLabel => 'Ví dụ';

  @override
  String get comingSoon => 'Tính năng đang được phát triển';

  @override
  String get tapToFlip => 'Chạm để lật';

  @override
  String get markNotLearned => 'Chưa thuộc';

  @override
  String get markLearned => 'Đã thuộc';

  @override
  String get flashcardDone => 'Hoàn thành bộ thẻ!';

  @override
  String flashcardDoneSub(int learned, int total) {
    return 'Bạn đã thuộc $learned/$total từ';
  }

  @override
  String get studyAgain => 'Học lại';

  @override
  String get backToSet => 'Quay lại';

  @override
  String quizQuestionNumber(int current, int total) {
    return 'Câu $current/$total';
  }

  @override
  String get quizChooseAnswer => 'Chọn đáp án đúng';

  @override
  String quizQuestionText(String word) {
    return 'Nghĩa của từ “$word” là gì?';
  }

  @override
  String get quizCorrect => 'Chính xác!';

  @override
  String get quizWrong => 'Chưa đúng';

  @override
  String quizCorrectExplain(String word, String meaning) {
    return '“$word” có nghĩa là “$meaning”.';
  }

  @override
  String get quizNext => 'Tiếp theo';

  @override
  String get quizFinish => 'Xem kết quả';

  @override
  String get quizExitTitle => 'Thoát bài quiz?';

  @override
  String get quizExitMessage => 'Kết quả của lần làm này sẽ không được lưu.';

  @override
  String get quizExitConfirm => 'Thoát';

  @override
  String get quizExitCancel => 'Ở lại';

  @override
  String get resultTitle => 'Hoàn thành bài quiz!';

  @override
  String get resultMessageHigh => 'Xuất sắc!';

  @override
  String get resultMessageMid => 'Bạn làm khá tốt';

  @override
  String get resultMessageLow => 'Cố gắng thêm nhé';

  @override
  String get resultScoreUnit => 'điểm';

  @override
  String get resultCorrect => 'Đúng';

  @override
  String get resultWrong => 'Sai';

  @override
  String get resultTime => 'Thời gian';

  @override
  String get resultReviewTitle => 'Từ cần ôn lại';

  @override
  String get resultPerfect => 'Bạn trả lời đúng tất cả!';

  @override
  String get resultRetry => 'Làm lại';

  @override
  String get resultHome => 'Về trang chủ';

  @override
  String get statsSubtitle => 'Theo dõi hành trình học của bạn';

  @override
  String get statLearned => 'Từ đã thuộc';

  @override
  String get statQuizzes => 'Quiz đã làm';

  @override
  String get statAverage => 'Điểm trung bình';

  @override
  String get chartTitle => 'Số từ học theo ngày';

  @override
  String get recentTitle => 'Kết quả quiz gần đây';

  @override
  String get recentEmpty => 'Chưa có kết quả quiz nào';

  @override
  String get weekdayLabels => 'T2,T3,T4,T5,T6,T7,CN';

  @override
  String get settingsSubtitle => 'Cá nhân hóa trải nghiệm học';

  @override
  String get dailyGoalTitle => 'Mục tiêu học mỗi ngày';

  @override
  String get dailyGoalSubtitle => 'Duy trì thói quen học đều đặn';

  @override
  String get aboutTitle => 'Thông tin nhóm';

  @override
  String get aboutSubtitle => 'Thông tin về dự án WordTH';

  @override
  String get versionLabel => 'Phiên bản';

  @override
  String get infoFullName => 'Họ tên';

  @override
  String get infoStudentId => 'MSSV';

  @override
  String get infoClass => 'Lớp';

  @override
  String get infoEmail => 'Email';

  @override
  String get projectInfoTitle => 'Thông tin dự án';

  @override
  String get projectTopicLabel => 'Đề tài';

  @override
  String get projectTopicValue => 'Ứng dụng học từ vựng';

  @override
  String get projectCourseLabel => 'Môn học';

  @override
  String get projectCourseValue => 'Lập trình thiết bị di động';

  @override
  String get githubLabel => 'GitHub';

  @override
  String get githubOpenFailed => 'Không mở được liên kết';

  @override
  String get membersTitle => 'Thành viên';

  @override
  String favoritesCount(int count) {
    return '$count từ đã lưu';
  }

  @override
  String get favoritesEmptyHint =>
      'Bấm biểu tượng trái tim ở danh sách từ để lưu từ yêu thích';

  @override
  String favoritesRemoved(String word) {
    return 'Đã bỏ “$word” khỏi yêu thích';
  }

  @override
  String get undo => 'Hoàn tác';

  @override
  String get themeTitle => 'Giao diện';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

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
