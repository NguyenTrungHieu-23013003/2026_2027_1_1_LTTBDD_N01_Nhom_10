import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_palette.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'providers/app_state.dart';
import 'screens/splash_screen.dart';

class WordThApp extends StatelessWidget {
  const WordThApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.select<AppState, Locale>((s) => s.locale);
    final themeMode = context.select<AppState, ThemeMode>((s) => s.themeMode);

    return MaterialApp(
      title: 'WordTH',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
      builder: (context, child) {
        final size = MediaQuery.sizeOf(context);
        return ColoredBox(
          color: context.colors.border,
          child: Center(
            child: SizedBox(
              width: size.width > 480 ? 480 : size.width,
              height: size.height,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
