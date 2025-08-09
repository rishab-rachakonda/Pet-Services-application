import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Navigation item for the bottom navigation bar
class NavigationItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final String route;

  const NavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    required this.route,
  });
}

/// Custom bottom navigation bar for pet service aggregation app
/// Implements warm professional styling with haptic feedback
class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double elevation;
  final BottomNavigationBarType type;

  // Hardcoded navigation items for pet service app
  static const List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
      route: '/home-screen',
    ),
    NavigationItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Services',
      route: '/service-listing-screen',
    ),
    NavigationItem(
      icon: Icons.pets_outlined,
      activeIcon: Icons.pets,
      label: 'Pet Centers',
      route: '/pet-center-detail-screen',
    ),
  ];

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.type = BottomNavigationBarType.fixed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color:
            backgroundColor ?? theme.bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex.clamp(0, _navigationItems.length - 1),
          onTap: (index) {
            HapticFeedback.lightImpact();

            // Navigate to the selected route
            final selectedItem = _navigationItems[index];
            if (ModalRoute.of(context)?.settings.name != selectedItem.route) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                selectedItem.route,
                (route) => false,
              );
            }

            onTap?.call(index);
          },
          type: type,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: selectedItemColor ??
              theme.bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor: unselectedItemColor ??
              theme.bottomNavigationBarTheme.unselectedItemColor,
          selectedLabelStyle: theme.bottomNavigationBarTheme.selectedLabelStyle,
          unselectedLabelStyle:
              theme.bottomNavigationBarTheme.unselectedLabelStyle,
          items: _navigationItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = currentIndex == index;

            return BottomNavigationBarItem(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isSelected && item.activeIcon != null
                      ? item.activeIcon!
                      : item.icon,
                  key: ValueKey(isSelected),
                  size: 24,
                ),
              ),
              label: item.label,
              tooltip: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Get the current route based on the current index
  String getCurrentRoute() {
    if (currentIndex >= 0 && currentIndex < _navigationItems.length) {
      return _navigationItems[currentIndex].route;
    }
    return _navigationItems[0].route;
  }

  /// Get the index for a given route
  static int getIndexForRoute(String route) {
    for (int i = 0; i < _navigationItems.length; i++) {
      if (_navigationItems[i].route == route) {
        return i;
      }
    }
    return 0; // Default to home
  }

  /// Factory constructor for home screen
  factory CustomBottomBar.home({
    Key? key,
    ValueChanged<int>? onTap,
  }) {
    return CustomBottomBar(
      key: key,
      currentIndex: 0,
      onTap: onTap,
    );
  }

  /// Factory constructor for services screen
  factory CustomBottomBar.services({
    Key? key,
    ValueChanged<int>? onTap,
  }) {
    return CustomBottomBar(
      key: key,
      currentIndex: 1,
      onTap: onTap,
    );
  }

  /// Factory constructor for pet centers screen
  factory CustomBottomBar.petCenters({
    Key? key,
    ValueChanged<int>? onTap,
  }) {
    return CustomBottomBar(
      key: key,
      currentIndex: 2,
      onTap: onTap,
    );
  }
}

/// Extension to help with bottom navigation state management
extension CustomBottomBarExtension on BuildContext {
  /// Get the appropriate bottom bar index for the current route
  int getBottomBarIndex() {
    final currentRoute = ModalRoute.of(this)?.settings.name;
    return CustomBottomBar.getIndexForRoute(currentRoute ?? '/home-screen');
  }
}
