import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom app bar widget for pet service aggregation app
/// Implements contemporary spatial minimalism with warm professional styling
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final double? leadingWidth;
  final TextStyle? titleTextStyle;
  final double toolbarOpacity;
  final double bottomOpacity;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.leadingWidth,
    this.titleTextStyle,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.systemOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: Text(
        title,
        style: titleTextStyle ??
            theme.appBarTheme.titleTextStyle?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.15,
            ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? theme.appBarTheme.foregroundColor,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading && showBackButton,
      leading: leading ??
          (showBackButton && Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: onBackPressed ??
                      () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                  tooltip: 'Back',
                )
              : null),
      leadingWidth: leadingWidth,
      actions: actions?.map((action) {
        if (action is IconButton) {
          return IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              action.onPressed?.call();
            },
            icon: action.icon,
            tooltip: action.tooltip,
            iconSize: 24,
          );
        }
        return action;
      }).toList(),
      bottom: bottom,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      systemOverlayStyle: systemOverlayStyle ??
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: theme.brightness == Brightness.light
                ? Brightness.dark
                : Brightness.light,
            statusBarBrightness: theme.brightness,
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  /// Factory constructor for home screen app bar
  factory CustomAppBar.home({
    Key? key,
    String title = 'Pet Services',
    List<Widget>? actions,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      showBackButton: false,
      actions: actions ??
          [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Handle notifications
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Notifications',
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Handle profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Profile',
              ),
            ),
          ],
    );
  }

  /// Factory constructor for search app bar
  factory CustomAppBar.search({
    Key? key,
    String title = 'Search Services',
    VoidCallback? onSearchPressed,
    VoidCallback? onFilterPressed,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              HapticFeedback.lightImpact();
              onSearchPressed?.call();
            },
            tooltip: 'Search',
          ),
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              HapticFeedback.lightImpact();
              onFilterPressed?.call();
            },
            tooltip: 'Filter',
          ),
        ),
      ],
    );
  }

  /// Factory constructor for detail screen app bar
  factory CustomAppBar.detail({
    Key? key,
    required String title,
    VoidCallback? onFavoritePressed,
    VoidCallback? onSharePressed,
    bool isFavorite = false,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Theme.of(context).colorScheme.error : null,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              onFavoritePressed?.call();
            },
            tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
          ),
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              HapticFeedback.lightImpact();
              onSharePressed?.call();
            },
            tooltip: 'Share',
          ),
        ),
      ],
    );
  }
}
