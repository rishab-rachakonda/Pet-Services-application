import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ServiceProviderCard extends StatelessWidget {
  final Map<String, dynamic> provider;
  final VoidCallback? onTap;
  final VoidCallback? onCall;
  final VoidCallback? onDirections;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const ServiceProviderCard({
    super.key,
    required this.provider,
    this.onTap,
    this.onCall,
    this.onDirections,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool isOpen = provider['isOpen'] ?? false;
    final double rating = (provider['rating'] ?? 0.0).toDouble();
    final List<dynamic> serviceTypes = provider['serviceTypes'] ?? [];
    final List<dynamic> petTypes = provider['petTypes'] ?? [];
    final String distance = provider['distance'] ?? '0.0 km';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap?.call();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Provider Image and Basic Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Provider Image
                    Hero(
                      tag: 'provider_${provider['id']}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImageWidget(
                          imageUrl: provider['image'] ?? '',
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    // Provider Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Provider Name
                          Text(
                            provider['name'] ?? 'Unknown Provider',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          // Location
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'location_on',
                                color: colorScheme.onSurfaceVariant,
                                size: 16,
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                child: Text(
                                  provider['location'] ??
                                      'Location not available',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          // Rating and Distance
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'star',
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                rating.toStringAsFixed(1),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '• $distance',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Availability Status
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: isOpen
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isOpen ? Colors.green : Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        isOpen ? 'Open' : 'Closed',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isOpen ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                // Service Types
                if (serviceTypes.isNotEmpty) ...[
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: serviceTypes.take(3).map((service) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          service.toString(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 1.h),
                ],
                // Pet Types and Actions
                Row(
                  children: [
                    // Pet Types
                    if (petTypes.isNotEmpty) ...[
                      Expanded(
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'pets',
                              color: colorScheme.onSurfaceVariant,
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Expanded(
                              child: Text(
                                petTypes.take(3).join(', '),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      const Spacer(),
                    ],
                    // Quick Actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Call Button
                        IconButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            onCall?.call();
                          },
                          icon: CustomIconWidget(
                            iconName: 'phone',
                            color: colorScheme.primary,
                            size: 20,
                          ),
                          tooltip: 'Call',
                          constraints: BoxConstraints(
                            minWidth: 8.w,
                            minHeight: 8.w,
                          ),
                        ),
                        // Directions Button
                        IconButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            onDirections?.call();
                          },
                          icon: CustomIconWidget(
                            iconName: 'directions',
                            color: colorScheme.primary,
                            size: 20,
                          ),
                          tooltip: 'Directions',
                          constraints: BoxConstraints(
                            minWidth: 8.w,
                            minHeight: 8.w,
                          ),
                        ),
                        // Favorite Button
                        IconButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            onFavorite?.call();
                          },
                          icon: CustomIconWidget(
                            iconName:
                                isFavorite ? 'favorite' : 'favorite_border',
                            color: isFavorite
                                ? Colors.red
                                : colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          tooltip: isFavorite
                              ? 'Remove from favorites'
                              : 'Add to favorites',
                          constraints: BoxConstraints(
                            minWidth: 8.w,
                            minHeight: 8.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
