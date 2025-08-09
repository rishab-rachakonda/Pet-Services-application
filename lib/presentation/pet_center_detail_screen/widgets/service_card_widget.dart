import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ServiceCardWidget extends StatefulWidget {
  final Map<String, dynamic> service;

  const ServiceCardWidget({
    super.key,
    required this.service,
  });

  @override
  State<ServiceCardWidget> createState() => _ServiceCardWidgetState();
}

class _ServiceCardWidgetState extends State<ServiceCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          (widget.service["name"] as String?) ?? "Service",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Text(
          (widget.service["price"] as String?) ?? "\$0",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        trailing: Icon(
          _isExpanded ? Icons.expand_less : Icons.expand_more,
          color: AppTheme.lightTheme.colorScheme.primary,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.service["description"] != null) ...[
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    (widget.service["description"] as String?) ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 2.h),
                ],
                if (widget.service["duration"] != null) ...[
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "Duration: ${(widget.service["duration"] as String?) ?? ""}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                ],
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'attach_money',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "Price: ${(widget.service["price"] as String?) ?? "\$0"}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
