import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheet({
    super.key,
    required this.currentFilters,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Map<String, dynamic> _filters;
  double _minRating = 0.0;
  double _maxDistance = 50.0;
  Set<String> _selectedFacilityTypes = {};
  Set<String> _selectedPetTypes = {};

  final List<String> _facilityTypes = [
    'Veterinary Clinic',
    'Pet Grooming',
    'Pet Boarding',
    'Pet Training',
    'Pet Store',
    'Emergency Care',
  ];

  final List<String> _petTypes = [
    'Dogs',
    'Cats',
    'Birds',
    'Fish',
    'Rabbits',
    'Reptiles',
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
    _minRating = (_filters['minRating'] ?? 0.0).toDouble();
    _maxDistance = (_filters['maxDistance'] ?? 50.0).toDouble();
    _selectedFacilityTypes = Set<String>.from(_filters['facilityTypes'] ?? []);
    _selectedPetTypes = Set<String>.from(_filters['petTypes'] ?? []);
  }

  void _applyFilters() {
    final updatedFilters = {
      'minRating': _minRating,
      'maxDistance': _maxDistance,
      'facilityTypes': _selectedFacilityTypes.toList(),
      'petTypes': _selectedPetTypes.toList(),
    };

    HapticFeedback.lightImpact();
    widget.onApplyFilters(updatedFilters);
    Navigator.pop(context);
  }

  void _clearFilters() {
    setState(() {
      _minRating = 0.0;
      _maxDistance = 50.0;
      _selectedFacilityTypes.clear();
      _selectedPetTypes.clear();
    });
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  'Filter Services',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearFilters,
                  child: Text(
                    'Clear All',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Filter
                  _buildSectionTitle('Minimum Rating'),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _minRating,
                          min: 0.0,
                          max: 5.0,
                          divisions: 10,
                          label: '${_minRating.toStringAsFixed(1)} stars',
                          onChanged: (value) {
                            setState(() {
                              _minRating = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'star',
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              _minRating.toStringAsFixed(1),
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  // Distance Filter
                  _buildSectionTitle('Maximum Distance'),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _maxDistance,
                          min: 1.0,
                          max: 100.0,
                          divisions: 99,
                          label: '${_maxDistance.toStringAsFixed(0)} km',
                          onChanged: (value) {
                            setState(() {
                              _maxDistance = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${_maxDistance.toStringAsFixed(0)} km',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  // Facility Types
                  _buildSectionTitle('Service Types'),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: _facilityTypes.map((type) {
                      final isSelected = _selectedFacilityTypes.contains(type);
                      return FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedFacilityTypes.add(type);
                            } else {
                              _selectedFacilityTypes.remove(type);
                            }
                          });
                        },
                        backgroundColor: colorScheme.surface,
                        selectedColor:
                            colorScheme.primaryContainer.withValues(alpha: 0.2),
                        checkmarkColor: colorScheme.primary,
                        labelStyle: theme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.outline,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 3.h),

                  // Pet Types
                  _buildSectionTitle('Pet Types Supported'),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: _petTypes.map((type) {
                      final isSelected = _selectedPetTypes.contains(type);
                      return FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedPetTypes.add(type);
                            } else {
                              _selectedPetTypes.remove(type);
                            }
                          });
                        },
                        backgroundColor: colorScheme.surface,
                        selectedColor: colorScheme.secondaryContainer
                            .withValues(alpha: 0.2),
                        checkmarkColor: colorScheme.secondary,
                        labelStyle: theme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? colorScheme.secondary
                              : colorScheme.onSurface,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? colorScheme.secondary
                              : colorScheme.outline,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
          // Action Buttons
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                      child: Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
