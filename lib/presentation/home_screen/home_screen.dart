import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_chips_widget.dart';
import './widgets/featured_centers_list_widget.dart';
import './widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String? selectedCategory;
  List<Map<String, dynamic>> filteredCenters = [];
  late TabController _tabController;

  final List<Map<String, dynamic>> allPetCenters = [
    {
      "id": 1,
      "name": "Happy Paws Veterinary Clinic",
      "location": "Road No 7 Banjara Hills",
      "rating": 4.8,
      "image":
          "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "services": ["Veterinary", "Emergency Care", "Surgery"],
      "isOpen": true,
      "isFavorite": false,
      "category": "Vet",
      "phone": "+91-9876543210",
      "description":
          "Full-service veterinary clinic providing comprehensive pet healthcare with experienced veterinarians and modern facilities."
    },
    {
      "id": 2,
      "name": "Javed Habib Pets Grooming Salon",
      "location": "MN crux, Second Floor, kokapet",
      "rating": 3.6,
      "image":
          "https://images.unsplash.com/photo-1560807707-8cc77767d783?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "services": ["Grooming", "Nail Trimming", "Bath & Brush"],
      "isOpen": true,
      "isFavorite": true,
      "category": "Grooming",
      "phone": "+91-8364829173",
      "description":
          "Professional pet grooming services with certified groomers specializing in all breeds and sizes."
    },
    {
      "id": 3,
      "name": "Doggesh Bhai Pet Boarding",
      "location": "123 ABC Nagar, Secunderabad",
      "rating": 4.2,
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRkjFYjqQiE3x6JHQq497QSwRtBybfhNAYDQ&s",
      "services": ["Boarding", "Daycare", "Pet Sitting"],
      "isOpen": false,
      "isFavorite": false,
      "category": "Boarding",
      "phone": "+91-9238492738",
      "description":
          "Safe and comfortable boarding facility with spacious accommodations and 24/7 supervision for your beloved pets."
    },
    {
      "id": 4,
      "name": "Commando Kernels Training Academy",
      "location": "Road no 2, Sainik road, suchitra",
      "rating": 4.9,
      "image":
          "https://images.unsplash.com/photo-1587300003388-59208cc962cb?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "services": ["Training", "Obedience Classes", "Behavioral Therapy"],
      "isOpen": true,
      "isFavorite": false,
      "category": "Training",
      "phone": "+91-9102937485",
      "description":
          "Expert dog training services with certified trainers offering personalized programs for dogs of all ages and temperaments."
    },
    {
      "id": 5,
      "name": "Sai Ram Pet Walking",
      "location": "Beside Sai Baba temple, Osman sagar",
      "rating": 4.5,
      "image":
          "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "services": ["Dog Walking", "Pet Exercise", "Companion Care"],
      "isOpen": true,
      "isFavorite": true,
      "category": "Walking",
      "phone": "+91-7283948192",
      "description":
          "Professional pet walking services providing daily exercise and companionship for your furry friends while you're away."
    },
    {
      "id": 6,
      "name": "Indra Gandhi Memorial Vetenarian Hospital",
      "location": "1-45-1/2 Rowdy Road, Lakdikapul",
      "rating": 4.4,
      "image":
          "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "services": ["Emergency Care", "Surgery", "Diagnostics"],
      "isOpen": true,
      "isFavorite": false,
      "category": "Vet",
      "phone": "+91-9773929229",
      "description":
          "24/7 emergency veterinary hospital equipped with advanced medical technology and experienced emergency veterinarians."
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    filteredCenters = List.from(allPetCenters);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _filterCentersByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredCenters = List.from(allPetCenters);
      } else {
        filteredCenters = allPetCenters
            .where((center) => center['category'] == category)
            .toList();
      }
    });
  }

  void _toggleFavorite(Map<String, dynamic> center) {
    setState(() {
      final index = allPetCenters.indexWhere((c) => c['id'] == center['id']);
      if (index != -1) {
        allPetCenters[index]['isFavorite'] =
            !(allPetCenters[index]['isFavorite'] ?? false);
        // Update filtered list as well
        final filteredIndex =
            filteredCenters.indexWhere((c) => c['id'] == center['id']);
        if (filteredIndex != -1) {
          filteredCenters[filteredIndex]['isFavorite'] =
              allPetCenters[index]['isFavorite'];
        }
      }
    });

    HapticFeedback.lightImpact();
    final bool isFavorite = center['isFavorite'] ?? false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Removed from favorites' : 'Added to favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _refreshCenters() async {
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      // Simulate refreshing data
      if (selectedCategory == null || selectedCategory == 'All') {
        filteredCenters = List.from(allPetCenters);
      } else {
        filteredCenters = allPetCenters
            .where((center) => center['category'] == selectedCategory)
            .toList();
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pet centers updated!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToPetCenterDetail(Map<String, dynamic> center) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(
      context,
      '/pet-center-detail-screen',
      arguments: center,
    );
  }

  void _handleBookAppointment(Map<String, dynamic> center) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book Appointment'),
        content: Text('Book an appointment with ${center['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Appointment booking feature coming soon!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text('Book'),
          ),
        ],
      ),
    );
  }

  void _navigateToSearch() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/service-listing-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Tab Bar
            Container(
              color: AppTheme.lightTheme.scaffoldBackgroundColor,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Home', icon: Icon(Icons.home)),
                  Tab(text: 'Search', icon: Icon(Icons.search)),
                  Tab(text: 'Favorites', icon: Icon(Icons.favorite)),
                  Tab(text: 'Profile', icon: Icon(Icons.person)),
                ],
              ),
            ),
            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Home Tab Content
                  _buildHomeContent(),
                  // Search Tab Content
                  _buildSearchContent(),
                  // Favorites Tab Content
                  _buildFavoritesContent(),
                  // Profile Tab Content
                  _buildProfileContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header with Search Bar
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'Find the best care\nfor your pet',
                  style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SearchBarWidget(
                onTap: _navigateToSearch,
                hintText: 'Find pet services near you',
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
        // Category Chips
        SliverToBoxAdapter(
          child: CategoryChipsWidget(
            selectedCategory: selectedCategory,
            onCategorySelected: _filterCentersByCategory,
          ),
        ),
        // Featured Centers Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategory == null || selectedCategory == 'All'
                      ? 'Featured Pet Centers'
                      : '$selectedCategory Services',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: _navigateToSearch,
                  child: Text('View All'),
                ),
              ],
            ),
          ),
        ),
        // Featured Centers List
        SliverFillRemaining(
          child: FeaturedCentersListWidget(
            petCenters: filteredCenters,
            onCenterTap: _navigateToPetCenterDetail,
            onBookPressed: _handleBookAppointment,
            onFavoritePressed: _toggleFavorite,
            onRefresh: _refreshCenters,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchContent() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'search',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 80,
            ),
            SizedBox(height: 3.h),
            Text(
              'Advanced Search',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Use advanced filters to find the perfect pet service provider for your needs.',
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: _navigateToSearch,
              child: Text('Go to Search'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesContent() {
    final favoriteCenters =
        allPetCenters.where((center) => center['isFavorite'] == true).toList();

    if (favoriteCenters.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'favorite_border',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 80,
              ),
              SizedBox(height: 3.h),
              Text(
                'No Favorites Yet',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Start adding pet service providers to your favorites to see them here.',
                textAlign: TextAlign.center,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FeaturedCentersListWidget(
      petCenters: favoriteCenters,
      onCenterTap: _navigateToPetCenterDetail,
      onBookPressed: _handleBookAppointment,
      onFavoritePressed: _toggleFavorite,
      onRefresh: _refreshCenters,
    );
  }

  Widget _buildProfileContent() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 15.w,
              backgroundColor: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              child: CustomIconWidget(
                iconName: 'person',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 60,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Your Profile',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Manage your account settings, view booking history, and update your pet information.',
              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile feature coming soon!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Setup Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
