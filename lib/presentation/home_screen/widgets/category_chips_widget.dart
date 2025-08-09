import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CategoryChipsWidget extends StatefulWidget {
  final Function(String)? onCategorySelected;
  final String? selectedCategory;

  const CategoryChipsWidget({
    super.key,
    this.onCategorySelected,
    this.selectedCategory,
  });

  @override
  State<CategoryChipsWidget> createState() => _CategoryChipsWidgetState();
}

class _CategoryChipsWidgetState extends State<CategoryChipsWidget> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': 'pets'},
    {'name': 'Grooming', 'icon': 'content_cut'},
    {'name': 'Boarding', 'icon': 'home'},
    {'name': 'Vet', 'icon': 'local_hospital'},
    {'name': 'Training', 'icon': 'school'},
    {'name': 'Walking', 'icon': 'directions_walk'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 3.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = widget.selectedCategory == category['name'] ||
              (widget.selectedCategory == null && category['name'] == 'All');

          return GestureDetector(
            onTap: () => widget.onCategorySelected?.call(category['name']),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: category['icon'],
                    color: isSelected
                        ? AppTheme.lightTheme.colorScheme.onPrimary
                        : AppTheme.lightTheme.colorScheme.primary,
                    size: 18,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    category['name'],
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.lightTheme.colorScheme.primary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
