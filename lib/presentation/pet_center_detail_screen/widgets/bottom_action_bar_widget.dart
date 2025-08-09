import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BottomActionBarWidget extends StatelessWidget {
  final Map<String, dynamic> centerData;

  const BottomActionBarWidget({
    super.key,
    required this.centerData,
  });

  void _handleCall() {
    // Future implementation for calling
  }

  void _handleDirections() {
    // Future implementation for directions
  }

  void _handleShare() {
    // Future implementation for sharing
  }

  void _handleFavorite() {
    // Future implementation for favorites
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: 'phone',
                label: 'Call',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  _handleCall();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Call feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: _ActionButton(
                icon: 'directions',
                label: 'Directions',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  _handleDirections();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Directions feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: _ActionButton(
                icon: 'share',
                label: 'Share',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  _handleShare();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Share feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: _ActionButton(
                icon: 'favorite_border',
                label: 'Favorite',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  _handleFavorite();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Favorites feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
