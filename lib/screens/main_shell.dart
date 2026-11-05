import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import '../widgets/press_effects.dart';
import 'favorites_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';

/// Khung chứa 4 tab chính.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _unselectedIconKeys = List.generate(
    4,
    (_) => GlobalKey<SwayIconState>(),
  );
  final _selectedIconKeys = List.generate(4, (_) => GlobalKey<SwayIconState>());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomeScreen(),
          StatsScreen(),
          FavoritesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Stack(
          children: [
            NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: (i) {
                setState(() => _index = i);
                _unselectedIconKeys[i].currentState?.sway();
                _selectedIconKeys[i].currentState?.sway();
              },
              destinations: [
            NavigationDestination(
              icon: SwayIcon(
                key: _unselectedIconKeys[0],
                icon: const Icon(Icons.home_outlined),
              ),
              selectedIcon: SwayIcon(
                key: _selectedIconKeys[0],
                icon: const Icon(Icons.home),
              ),
              label: l10n.tabHome,
            ),
            NavigationDestination(
              icon: SwayIcon(
                key: _unselectedIconKeys[1],
                icon: const Icon(Icons.bar_chart_outlined),
              ),
              selectedIcon: SwayIcon(
                key: _selectedIconKeys[1],
                icon: const Icon(Icons.bar_chart),
              ),
              label: l10n.tabStats,
            ),
            NavigationDestination(
              icon: SwayIcon(
                key: _unselectedIconKeys[2],
                icon: const Icon(Icons.favorite_border),
              ),
              selectedIcon: SwayIcon(
                key: _selectedIconKeys[2],
                icon: const Icon(Icons.favorite),
              ),
              label: l10n.tabFavorites,
            ),
            NavigationDestination(
              icon: SwayIcon(
                key: _unselectedIconKeys[3],
                icon: const Icon(Icons.settings_outlined),
              ),
              selectedIcon: SwayIcon(
                key: _selectedIconKeys[3],
                icon: const Icon(Icons.settings),
              ),
              label: l10n.tabSettings,
            ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: IgnorePointer(
                child: SizedBox(
                  height: 3,
                  child: Row(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Expanded(
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: i == _index ? 28 : 0,
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
