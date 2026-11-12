import 'package:flutter/material.dart';

/// Bộ màu thay đổi theo chế độ sáng hoặc tối.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.primaryLight,
    required this.primaryDark,
  });

  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color primaryLight;
  final Color primaryDark;

  static const light = AppPalette(
    background: Color(0xFFF7F9FC),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1A2433),
    textSecondary: Color(0xFF6B7A90),
    border: Color(0xFFE3E8F0),
    primaryLight: Color(0xFFE8F0FD),
    primaryDark: Color(0xFF1B3F8F),
  );

  static const dark = AppPalette(
    background: Color(0xFF0F1623),
    surface: Color(0xFF1A2333),
    textPrimary: Color(0xFFEAF0FA),
    textSecondary: Color(0xFF9AA8BD),
    border: Color(0xFF2A3548),
    primaryLight: Color(0xFF1F3156),
    primaryDark: Color(0xFFA9C4FF),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? primaryLight,
    Color? primaryDark,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
    );
  }
}

/// Cách dùng trong màn hình: context.colors.surface, context.colors.border...
extension AppPaletteContext on BuildContext {
  AppPalette get colors =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
