import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final String? initialQuery;
  final Function(String) onSearchChanged;
  final VoidCallback? onFilterPressed;
  final bool hasActiveFilters;

  const SearchBarWidget({
    super.key,
    this.initialQuery,
    required this.onSearchChanged,
    this.onFilterPressed,
    this.hasActiveFilters = false,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged('');
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          // Search Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _focusNode.hasFocus
                      ? colorScheme.primary
                      : colorScheme.outline.withValues(alpha: 0.3),
                  width: _focusNode.hasFocus ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                onChanged: widget.onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search pet services...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'search',
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: _clearSearch,
                          icon: CustomIconWidget(
                            iconName: 'clear',
                            color: colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          tooltip: 'Clear search',
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _focusNode.unfocus();
                  HapticFeedback.lightImpact();
                },
              ),
            ),
          ),
          SizedBox(width: 3.w),
          // Filter Button
          Container(
            decoration: BoxDecoration(
              color: widget.hasActiveFilters
                  ? colorScheme.primary
                  : colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.hasActiveFilters
                    ? colorScheme.primary
                    : colorScheme.outline.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                widget.onFilterPressed?.call();
              },
              icon: Stack(
                children: [
                  CustomIconWidget(
                    iconName: 'tune',
                    color: widget.hasActiveFilters
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    size: 24,
                  ),
                  if (widget.hasActiveFilters)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              tooltip: 'Filter services',
              constraints: BoxConstraints(
                minWidth: 12.w,
                minHeight: 12.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
