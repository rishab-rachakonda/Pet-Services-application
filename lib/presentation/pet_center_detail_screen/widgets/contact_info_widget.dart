import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ContactInfoWidget extends StatelessWidget {
  final Map<String, dynamic> centerData;

  const ContactInfoWidget({
    super.key,
    required this.centerData,
  });

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Information",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 2.h),

          // Address
          if (centerData["address"] != null) ...[
            GestureDetector(
              onLongPress: () => _copyToClipboard(
                context,
                (centerData["address"] as String?) ?? "",
                "Address",
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIconWidget(
                    iconName: 'location_on',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          (centerData["address"] as String?) ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Directions feature coming soon'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: CustomIconWidget(
                      iconName: 'directions',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],

          // Phone
          if (centerData["phone"] != null) ...[
            GestureDetector(
              onLongPress: () => _copyToClipboard(
                context,
                (centerData["phone"] as String?) ?? "",
                "Phone number",
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'phone',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phone",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          (centerData["phone"] as String?) ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Call feature coming soon'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: CustomIconWidget(
                      iconName: 'call',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],

          // Email
          if (centerData["email"] != null) ...[
            GestureDetector(
              onLongPress: () => _copyToClipboard(
                context,
                (centerData["email"] as String?) ?? "",
                "Email",
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'email',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          (centerData["email"] as String?) ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email feature coming soon'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: CustomIconWidget(
                      iconName: 'mail_outline',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
