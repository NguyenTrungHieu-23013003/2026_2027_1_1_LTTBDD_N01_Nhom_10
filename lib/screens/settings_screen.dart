import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_spacing.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = context.watch<AppState>();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.settingsTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.languageTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.md),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'vi', label: Text(l10n.languageVi)),
              ButtonSegment(value: 'en', label: Text(l10n.languageEn)),
            ],
            selected: {state.lang},
            onSelectionChanged: (selection) =>
                state.setLocale(Locale(selection.first)),
          ),
        ],
      ),
    );
  }
}