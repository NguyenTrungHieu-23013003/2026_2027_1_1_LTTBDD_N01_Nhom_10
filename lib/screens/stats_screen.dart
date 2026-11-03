import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SafeArea(child: Center(child: Text(l10n.statsTitle)));
  }
}