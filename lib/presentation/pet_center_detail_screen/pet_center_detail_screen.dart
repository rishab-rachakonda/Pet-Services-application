import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/bottom_action_bar_widget.dart';
import './widgets/contact_info_widget.dart';
import './widgets/professional_card_widget.dart';
import './widgets/service_card_widget.dart';

class PetCenterDetailScreen extends StatefulWidget {
  const PetCenterDetailScreen({super.key});

  @override
  State<PetCenterDetailScreen> createState() => _PetCenterDetailScreenState();
}

class _PetCenterDetailScreenState extends State<PetCenterDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;
  bool _isFavorite = false;

  
  final Map<String, dynamic> _centerData = {
  "id": 1,
  "name": "Happy Care Veterinary Clinic",
  "image":
      "https://images.pexels.com/photos/6235233/pexels-photo-6235233.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "rating": 4.7,
  "reviewCount": 248,
  "address":
      "Plot No. 12, Road No. 2, Banjara Hills, Hyderabad, Telangana 500034",
  "phone": "+91 98765 43210",
  "email": "contact@pawfectcare.in",
  "website": "www.pawfectcare.in",
  "hours":
      "Mon-Fri: 9:00 AM - 7:00 PM, Sat: 9:00 AM - 5:00 PM, Sun: 10:00 AM - 2:00 PM",
  "description":
      "Pawfect Care Veterinary Clinic has been serving Hyderabad's pet community for over 10 years, providing compassionate and expert care. Our modern facility offers a wide range of veterinary services with experienced professionals committed to your pet's health and happiness.",
  "services": [
    {
      "name": "General Health Checkup",
      "price": "₹600",
      "duration": "30 minutes",
      "description":
          "Complete health examination including weight check, temperature, and overall wellness assessment for your pet."
    },
    {
      "name": "Vaccination Package",
      "price": "₹1500",
      "duration": "20 minutes",
      "description":
          "Full vaccination package including core vaccines and health certificate to protect your pet from common diseases."
    },
    {
      "name": "Dental Cleaning",
      "price": "₹3500",
      "duration": "2 hours",
      "description":
          "Professional dental cleaning under anesthesia with scaling, polishing, and oral health evaluation."
    },
    {
      "name": "Emergency Care",
      "price": "₹2000",
      "duration": "45 minutes",
      "description":
          "24/7 emergency care for urgent medical situations. Immediate assessment and treatment provided."
    },
    {
      "name": "Grooming Service",
      "price": "₹1200",
      "duration": "1.5 hours",
      "description":
          "Complete grooming package including bath, nail trimming, ear cleaning, and coat styling."
    }
  ],
  "professionals": [
    {
      "name": "Dr. Ananya Reddy",
      "title": "Chief Veterinarian",
      "image":
          "https://images.pexels.com/photos/5407206/pexels-photo-5407206.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "specialization": "Small Animal Medicine"
    },
    {
      "name": "Dr. Arjun Menon",
      "title": "Emergency Specialist",
      "image":
          "https://images.pexels.com/photos/6749778/pexels-photo-6749778.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "specialization": "Emergency & Critical Care"
    },
    {
      "name": "Priya Sharma",
      "title": "Veterinary Technician",
      "image":
          "https://images.pexels.com/photos/5407764/pexels-photo-5407764.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "specialization": "Patient Care"
    },
    {
      "name": "Rahul Varma",
      "title": "Pet Groomer",
      "image":
          "https://images.pexels.com/photos/6235067/pexels-photo-6235067.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "specialization": "Professional Grooming"
    }
  ],
  "petTypes": ["Dogs", "Cats", "Birds", "Rabbits"],
  "facilities": [
    "Parking Available",
    "Wheelchair Accessible",
    "Air Conditioned",
    "Spacious Waiting Area"
  ],
  "isOpen": true,
  "distance": "3.1 km"
};


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 200 && !_showTitle) {
      setState(() {
        _showTitle = true;
      });
    } else if (_scrollController.offset <= 200 && _showTitle) {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Image with SliverAppBar
              SliverAppBar(
                expandedHeight: 40.h,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
                leading: Container(
                  margin: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: CustomIconWidget(
                      iconName: 'arrow_back_ios_new',
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                  ),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: CustomIconWidget(
                        iconName: _isFavorite ? 'favorite' : 'favorite_border',
                        color: _isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_isFavorite
                                ? 'Added to favorites'
                                : 'Removed from favorites'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle
                      ? Text(
                          (_centerData["name"] as String?) ?? "",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              const Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        )
                      : null,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomImageWidget(
                        imageUrl: (_centerData["image"] as String?) ?? "",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center Name and Rating
                    Container(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (_centerData["name"] as String?) ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'star',
                                color: Colors.amber,
                                size: 20,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                "${(_centerData["rating"] as double?) ?? 0.0}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                "(${(_centerData["reviewCount"] as int?) ?? 0} reviews)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: (_centerData["isOpen"] as bool?) ==
                                          true
                                      ? AppTheme.lightTheme.colorScheme.tertiary
                                          .withValues(alpha: 0.1)
                                      : AppTheme.lightTheme.colorScheme.error
                                          .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  (_centerData["isOpen"] as bool?) == true
                                      ? "Open"
                                      : "Closed",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color:
                                            (_centerData["isOpen"] as bool?) ==
                                                    true
                                                ? AppTheme.lightTheme
                                                    .colorScheme.tertiary
                                                : AppTheme.lightTheme
                                                    .colorScheme.error,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          if (_centerData["distance"] != null) ...[
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'location_on',
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                  size: 16,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  "${(_centerData["distance"] as String?) ?? ""} away",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Description
                    if (_centerData["description"] != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              (_centerData["description"] as String?) ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],

                    // Contact Information
                    ContactInfoWidget(centerData: _centerData),

                    // Pet Types and Facilities
                    if (_centerData["petTypes"] != null ||
                        _centerData["facilities"] != null) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_centerData["petTypes"] != null) ...[
                              Text(
                                "Pet Types Served",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 1.h),
                              Wrap(
                                spacing: 2.w,
                                runSpacing: 1.h,
                                children:
                                    ((_centerData["petTypes"] as List?) ?? [])
                                        .map((petType) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    decoration: BoxDecoration(
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      petType as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: AppTheme
                                                .lightTheme.colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 2.h),
                            ],
                            if (_centerData["facilities"] != null) ...[
                              Text(
                                "Facilities",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: 1.h),
                              Column(
                                children:
                                    ((_centerData["facilities"] as List?) ?? [])
                                        .map((facility) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: Row(
                                      children: [
                                        CustomIconWidget(
                                          iconName: 'check_circle',
                                          color: AppTheme
                                              .lightTheme.colorScheme.tertiary,
                                          size: 16,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          facility as String,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],

                    // Services Section
                    if (_centerData["services"] != null) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          "Services & Pricing",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Column(
                        children: ((_centerData["services"] as List?) ?? [])
                            .map((service) {
                          return ServiceCardWidget(
                            service: service as Map<String, dynamic>,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 3.h),
                    ],

                    // Professionals Section
                    if (_centerData["professionals"] != null) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          "Our Team",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          itemCount:
                              ((_centerData["professionals"] as List?) ?? [])
                                  .length,
                          itemBuilder: (context, index) {
                            final professional =
                                ((_centerData["professionals"] as List?) ??
                                    [])[index] as Map<String, dynamic>;
                            return ProfessionalCardWidget(
                              professional: professional,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${professional["name"]} profile coming soon'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],

                    // Book Appointment Button
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Booking feature coming soon'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Book Appointment",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom spacing for action bar
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          ),

          // Floating Action Button for scroll to top
          Positioned(
            right: 4.w,
            bottom: 15.h,
            child: FloatingActionButton(
              mini: true,
              onPressed: _scrollToTop,
              child: CustomIconWidget(
                iconName: 'keyboard_arrow_up',
                color: AppTheme.lightTheme.colorScheme.onSecondary,
                size: 24,
              ),
            ),
          ),
        ],
      ),

      // Bottom Action Bar
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomActionBarWidget(centerData: _centerData),
          CustomBottomBar.petCenters(),
        ],
      ),
    );
  }
}
