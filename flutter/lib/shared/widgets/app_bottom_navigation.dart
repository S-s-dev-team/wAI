import 'package:flutter/material.dart';

/// ボトムナビゲーションの各タブ定義。
class AppBottomNavItem {
  const AppBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });

  final String label;
  final Widget icon;

  /// 選択時に表示するアイコン。省略時は [icon] をそのまま使う。
  final Widget? activeIcon;
}

/// アプリ共通のボトムナビゲーションバー。
///
/// Material 3 の [NavigationBar] をラップし、
/// スタイルは [ColorScheme] に委譲する。
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final int currentIndex;
  final List<AppBottomNavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: item.icon,
              selectedIcon: item.activeIcon ?? item.icon,
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
