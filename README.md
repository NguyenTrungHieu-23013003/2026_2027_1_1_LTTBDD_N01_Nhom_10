# WordTH

Ứng dụng Flutter hỗ trợ học và ôn từ vựng tiếng Anh trên điện thoại. Người
dùng học theo bộ chủ đề bằng flashcard, làm quiz và theo dõi tiến độ học.

## Chức năng

- Xem và tìm kiếm từ vựng theo từ tiếng Anh hoặc nghĩa tiếng Việt/tiếng Anh.
- Học bằng flashcard: xem phiên âm, nghĩa, ví dụ và đánh dấu đã thuộc/chưa thuộc.
- Làm quiz trắc nghiệm 4 đáp án; xem kết quả, thời gian và các từ cần ôn.
- Đánh dấu từ yêu thích, xem thống kê học tập và đặt mục tiêu học mỗi ngày.
- Chuyển ngôn ngữ giao diện Việt/Anh và giao diện sáng/tối.
- Xem thông tin nhóm và mở trang GitHub của dự án.

Ứng dụng hiện có 4 bộ từ mẫu với tổng cộng 26 từ. Dữ liệu từ vựng được khai báo
trong mã nguồn; trạng thái học, yêu thích, lịch sử quiz và cài đặt chỉ lưu trong
bộ nhớ khi ứng dụng đang chạy, nên sẽ được đặt lại khi khởi động lại ứng dụng.
Các chức năng học không cần tài khoản, backend hay cơ sở dữ liệu.

## Công nghệ

- Flutter và Dart
- Provider để quản lý trạng thái
- Flutter Localizations và các tệp `.arb` cho tiếng Việt/tiếng Anh
- `fl_chart` cho biểu đồ thống kê
- `flutter_svg` cho hình ảnh SVG
- `url_launcher` để mở liên kết GitHub
- Font Be Vietnam Pro

## Chạy dự án

Cài Flutter SDK có Dart SDK đáp ứng ràng buộc trong `pubspec.yaml` (Dart
`^3.13.4`), sau đó chạy tại thư mục dự án:

```shell
flutter pub get
flutter gen-l10n
flutter run
```

Để chọn thiết bị cụ thể:

```shell
flutter devices
flutter run -d <device-id>
```

Tạo APK Android:

```shell
flutter build apk
```

## Cấu trúc chính

```text
lib/
  core/        Hằng số và giao diện sáng/tối
  data/        Dữ liệu từ vựng mẫu
  l10n/        Chuỗi giao diện Việt/Anh
  models/      Word, WordSet, QuizQuestion, QuizResult
  providers/   Trạng thái ứng dụng (AppState)
  screens/     Các màn hình của ứng dụng
  widgets/     Widget giao diện dùng lại
```

## Nhóm thực hiện

Môn học: Lập trình thiết bị di động

Nhóm 10 — lớp LTTBDD_N01

| Thành viên | Mã sinh viên |
| --- | --- |
| Nguyễn Trung Hiếu | 23013003 |
| Nguyễn Văn Hiệp | 23010859 |

Repository: [2026_2027_1_1_LTTBDD_N01_Nhom_10](https://github.com/NguyenTrungHieu-23013003/2026_2027_1_1_LTTBDD_N01_Nhom_10)
