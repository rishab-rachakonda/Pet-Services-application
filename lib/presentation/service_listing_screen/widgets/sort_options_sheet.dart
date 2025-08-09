import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

enum SortOption {
  distance,
  rating,
  availability,
  price,
}

class SortOptionsSheet extends StatelessWidget {
  final SortOption currentSort;
  final Function(SortOption) onSortChanged;

  const SortOptionsSheet({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final List<Map<String, dynamic>> sortOptions = [
      {
        'option': SortOption.distance,
        'title': 'Distance',
        'subtitle': 'Nearest first',
        'icon': 'location_on',
      },
      {
        'option': SortOption.rating,
        'title': 'Rating',
        'subtitle': 'Highest rated first',
        'icon': 'star',
      },
      {
        'option': SortOption.availability,
        'title': 'Availability',
        'subtitle': 'Open services first',
        'icon': 'schedule',
      },
      {
        'option': SortOption.price,
        'title': 'Price',
        'subtitle': 'Most affordable first',
        'icon': 'attach_money',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Sort By',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  },
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          // Sort Options
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortOptions.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.2),
            ),
            itemBuilder: (context, index) {
              final option = sortOptions[index];
              final sortOption = option['option'] as SortOption;
              final isSelected = currentSort == sortOption;

              return ListTile(
                leading: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primaryContainer.withValues(alpha: 0.2)
                        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: option['icon'],
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                title: Text(
                  option['title'],
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  option['subtitle'],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                trailing: isSelected
                    ? CustomIconWidget(
                        iconName: 'check_circle',
                        color: colorScheme.primary,
                        size: 24,
                      )
                    : null,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onSortChanged(sortOption);
                  Navigator.pop(context);
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              );
            },
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
