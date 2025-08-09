import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final String iconName;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.onActionPressed,
    this.iconName = 'search_off',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: colorScheme.onSurfaceVariant,
                size: 15.w,
              ),
            ),
            SizedBox(height: 4.h),
            // Title
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            // Subtitle
            Text(
              subtitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionPressed != null) ...[
              SizedBox(height: 4.h),
              // Action Button
              ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onActionPressed?.call();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                ),
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Factory constructors for common empty states
  factory EmptyStateWidget.noResults({
    Key? key,
    VoidCallback? onClearFilters,
  }) {
    return EmptyStateWidget(
      key: key,
      title: 'No Services Found',
      subtitle:
          'We couldn\'t find any pet services matching your criteria. Try adjusting your filters or search terms.',
      actionText: 'Clear Filters',
      onActionPressed: onClearFilters,
      iconName: 'search_off',
    );
  }

  factory EmptyStateWidget.noServices({
    Key? key,
    VoidCallback? onRefresh,
  }) {
    return EmptyStateWidget(
      key: key,
      title: 'No Services Available',
      subtitle:
          'There are currently no pet services available in your area. Please try again later.',
      actionText: 'Refresh',
      onActionPressed: onRefresh,
      iconName: 'pets',
    );
  }

  factory EmptyStateWidget.networkError({
    Key? key,
    VoidCallback? onRetry,
  }) {
    return EmptyStateWidget(
      key: key,
      title: 'Connection Error',
      subtitle:
          'Unable to load pet services. Please check your internet connection and try again.',
      actionText: 'Retry',
      onActionPressed: onRetry,
      iconName: 'wifi_off',
    );
  }
}
