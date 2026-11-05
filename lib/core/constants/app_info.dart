class Member {
  const Member({
    required this.fullName,
    required this.initials,
    required this.studentId,
    required this.className,
    required this.email,
  });

  final String fullName;

  final String initials;
  final String studentId;
  final String className;
  final String email;
}

class AppInfo {
  AppInfo._();

  static const appVersion = '1.0.0';

  static const members = <Member>[
    Member(
      fullName: 'Nguyễn Trung Hiếu',
      initials: 'NTH',
      studentId: '23013003',
      className: 'LTTBDD_N01',
      email: '23013003@st.phenikaa-uni.edu.vn',
    ),
    Member(
      fullName: 'Trần Thị B',
      initials: 'TB',
      studentId: '22123457',
      className: 'LTTBDD_N01',
      email: '22123457@st.phenikaa-uni.edu.vn',
    ),
  ];

  static const githubUrl =
      'https://github.com/NguyenTrungHieu-23013003/2026_2027_1_1_LTTBDD_N01_Nhom_10.git';

  static String get githubDisplay => githubUrl.replaceFirst('https://', '');
}
