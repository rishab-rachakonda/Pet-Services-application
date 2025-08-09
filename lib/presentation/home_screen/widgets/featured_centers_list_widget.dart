import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './pet_center_card_widget.dart';

class FeaturedCentersListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> petCenters;
  final Function(Map<String, dynamic>)? onCenterTap;
  final Function(Map<String, dynamic>)? onBookPressed;
  final Function(Map<String, dynamic>)? onFavoritePressed;
  final RefreshCallback? onRefresh;

  const FeaturedCentersListWidget({
    super.key,
    required this.petCenters,
    this.onCenterTap,
    this.onBookPressed,
    this.onFavoritePressed,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (petCenters.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      color: AppTheme.lightTheme.colorScheme.primary,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: petCenters.length,
        itemBuilder: (context, index) {
          final petCenter = petCenters[index];

          return PetCenterCardWidget(
            petCenter: petCenter,
            onTap: () => onCenterTap?.call(petCenter),
            onBookPressed: () => onBookPressed?.call(petCenter),
            onFavoritePressed: () => onFavoritePressed?.call(petCenter),
            onSharePressed: () => _handleShare(context, petCenter),
            onDirectionsPressed: () => _handleDirections(context, petCenter),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'pets',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 80,
            ),
            SizedBox(height: 3.h),
            Text(
              'No Pet Services Found',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'We couldn\'t find any pet services in your area. Try adjusting your search or check back later.',
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/service-listing-screen');
              },
              child: Text('Explore Services'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleShare(BuildContext context, Map<String, dynamic> petCenter) {
    final String centerName = petCenter['name'] ?? 'Pet Center';
    final String location = petCenter['location'] ?? '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing $centerName...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleDirections(BuildContext context, Map<String, dynamic> petCenter) {
    final String centerName = petCenter['name'] ?? 'Pet Center';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Getting directions to $centerName...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
