import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet.dart';
import './widgets/search_bar_widget.dart';
import './widgets/service_provider_card.dart';
import './widgets/sort_options_sheet.dart';

class ServiceListingScreen extends StatefulWidget {
  const ServiceListingScreen({super.key});

  @override
  State<ServiceListingScreen> createState() => _ServiceListingScreenState();
}

class _ServiceListingScreenState extends State<ServiceListingScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  Map<String, dynamic> _activeFilters = {};
  SortOption _currentSort = SortOption.distance;
  bool _isLoading = false;
  bool _isRefreshing = false;
  List<Map<String, dynamic>> _allProviders = [];
  List<Map<String, dynamic>> _filteredProviders = [];
  final Set<int> _favoriteProviders = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _initializeData() {
    setState(() {
      _isLoading = true;
    });

    // Mock data for pet service providers
   final List<Map<String, dynamic>> _allProviders = [
  {
    "id": 1,
    "name": "Happy Paws Veterinary Clinic",
    "location": "Road No 7, Banjara Hills",
    "image":
        "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "rating": 4.8,
    "distance": "2.3 km",
    "isOpen": true,
    "serviceTypes": ["Veterinary", "Emergency Care", "Surgery"],
    "petTypes": ["Dogs", "Cats", "Birds"],
    "phone": "+91-9876543210",
    "priceRange": "₹₹₹",
    "description":
        "Full-service veterinary clinic providing comprehensive pet healthcare with experienced veterinarians and modern facilities."
  },
  {
    "id": 2,
    "name": "Javed Habib Pets Grooming Salon",
    "location": "MN Crux, Second Floor, Kokapet",
    "image":
        "https://images.unsplash.com/photo-1560807707-8cc77767d783?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "rating": 3.6,
    "distance": "5.1 km",
    "isOpen": true,
    "serviceTypes": ["Grooming", "Nail Trimming", "Bath & Brush"],
    "petTypes": ["Dogs", "Cats"],
    "phone": "+91-8364829173",
    "priceRange": "₹₹",
    "description":
        "Professional pet grooming services with certified groomers specializing in all breeds and sizes."
  },
  {
    "id": 3,
    "name": "Doggesh Bhai Pet Boarding",
    "location": "123 ABC Nagar, Secunderabad",
    "image":
        "https://images.unsplash.com/photo-1601758228041-f3b2795255f1?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "rating": 4.2,
    "distance": "7.8 km",
    "isOpen": false,
    "serviceTypes": ["Boarding", "Daycare", "Pet Sitting"],
    "petTypes": ["Dogs", "Cats", "Rabbits"],
    "phone": "+91-9238492738",
    "priceRange": "₹₹",
    "description":
        "Safe and comfortable boarding facility with spacious accommodations and 24/7 supervision for your beloved pets."
  },
  {
    "id": 4,
    "name": "Commando Kernels Training Academy",
    "location": "Road No 2, Sainik Road, Suchitra",
    "image":
        "https://images.unsplash.com/photo-1587300003388-59208cc962cb?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "rating": 4.9,
    "distance": "9.2 km",
    "isOpen": true,
    "serviceTypes": ["Training", "Obedience Classes", "Behavioral Therapy"],
    "petTypes": ["Dogs"],
    "phone": "+91-9102937485",
    "priceRange": "₹₹₹",
    "description":
        "Expert dog training services with certified trainers offering personalized programs for dogs of all ages and temperaments."
  },
  {
    "id": 5,
    "name": "Sai Ram Pet Walking",
    "location": "Beside Sai Baba Temple, Osman Sagar",
    "image":
        "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "rating": 4.5,
    "distance": "6.4 km",
    "isOpen": true,
    "serviceTypes": ["Dog Walking", "Pet Exercise", "Companion Care"],
    "petTypes": ["Dogs"],
    "phone": "+91-7283948192",
    "priceRange": "₹₹",
    "description":
        "Professional pet walking services providing daily exercise and companionship for your furry friends while you're away."
  },
  {
    "id": 6,
    "name": "Indra Gandhi Memorial Veterinarian Hospital",
    "location": "1-45-1/2 Rowdy Road, Lakdikapul",
    "image":
        "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "rating": 4.4,
    "distance": "3.8 km",
    "isOpen": true,
    "serviceTypes": ["Emergency Care", "Surgery", "Diagnostics"],
    "petTypes": ["Dogs", "Cats", "Birds"],
    "phone": "+91-9773929229",
    "priceRange": "₹₹₹",
    "description":
        "24/7 emergency veterinary hospital equipped with advanced medical technology and experienced emergency veterinarians."
  },
];

    _filteredProviders = List.from(_allProviders);
    _sortProviders();

    setState(() {
      _isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFiltersAndSearch();
  }

  void _applyFiltersAndSearch() {
    List<Map<String, dynamic>> filtered = List.from(_allProviders);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((provider) {
        final name = (provider['name'] ?? '').toString().toLowerCase();
        final location = (provider['location'] ?? '').toString().toLowerCase();
        final serviceTypes = (provider['serviceTypes'] as List? ?? [])
            .map((s) => s.toString().toLowerCase())
            .join(' ');
        final petTypes = (provider['petTypes'] as List? ?? [])
            .map((p) => p.toString().toLowerCase())
            .join(' ');

        final searchLower = _searchQuery.toLowerCase();
        return name.contains(searchLower) ||
            location.contains(searchLower) ||
            serviceTypes.contains(searchLower) ||
            petTypes.contains(searchLower);
      }).toList();
    }

    // Apply rating filter
    if (_activeFilters['minRating'] != null) {
      final minRating = (_activeFilters['minRating'] as double);
      filtered = filtered.where((provider) {
        final rating = (provider['rating'] ?? 0.0) as double;
        return rating >= minRating;
      }).toList();
    }

    // Apply distance filter
    if (_activeFilters['maxDistance'] != null) {
      final maxDistance = (_activeFilters['maxDistance'] as double);
      filtered = filtered.where((provider) {
        final distanceStr = (provider['distance'] ?? '0.0 km').toString();
        final distance =
            double.tryParse(distanceStr.replaceAll(' km', '')) ?? 0.0;
        return distance <= maxDistance;
      }).toList();
    }

    // Apply facility type filter
    if (_activeFilters['facilityTypes'] != null) {
      final facilityTypes =
          (_activeFilters['facilityTypes'] as List).cast<String>();
      if (facilityTypes.isNotEmpty) {
        filtered = filtered.where((provider) {
          final serviceTypes =
              (provider['serviceTypes'] as List? ?? []).cast<String>();
          return facilityTypes.any((type) => serviceTypes
              .any((service) => service.contains(type.split(' ').first)));
        }).toList();
      }
    }

    // Apply pet type filter
    if (_activeFilters['petTypes'] != null) {
      final petTypes = (_activeFilters['petTypes'] as List).cast<String>();
      if (petTypes.isNotEmpty) {
        filtered = filtered.where((provider) {
          final providerPetTypes =
              (provider['petTypes'] as List? ?? []).cast<String>();
          return petTypes.any((type) => providerPetTypes.contains(type));
        }).toList();
      }
    }

    setState(() {
      _filteredProviders = filtered;
    });
    _sortProviders();
  }

  void _sortProviders() {
    switch (_currentSort) {
      case SortOption.distance:
        _filteredProviders.sort((a, b) {
          final distanceA = double.tryParse((a['distance'] ?? '0.0 km')
                  .toString()
                  .replaceAll(' km', '')) ??
              0.0;
          final distanceB = double.tryParse((b['distance'] ?? '0.0 km')
                  .toString()
                  .replaceAll(' km', '')) ??
              0.0;
          return distanceA.compareTo(distanceB);
        });
        break;
      case SortOption.rating:
        _filteredProviders.sort((a, b) {
          final ratingA = (a['rating'] ?? 0.0) as double;
          final ratingB = (b['rating'] ?? 0.0) as double;
          return ratingB.compareTo(ratingA);
        });
        break;
      case SortOption.availability:
        _filteredProviders.sort((a, b) {
          final isOpenA = (a['isOpen'] ?? false) as bool;
          final isOpenB = (b['isOpen'] ?? false) as bool;
          if (isOpenA && !isOpenB) return -1;
          if (!isOpenA && isOpenB) return 1;
          return 0;
        });
        break;
      case SortOption.price:
        _filteredProviders.sort((a, b) {
          final priceA = (a['priceRange'] ?? '\$').toString().length;
          final priceB = (b['priceRange'] ?? '\$').toString().length;
          return priceA.compareTo(priceB);
        });
        break;
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        currentFilters: _activeFilters,
        onApplyFilters: (filters) {
          setState(() {
            _activeFilters = filters;
          });
          _applyFiltersAndSearch();
        },
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SortOptionsSheet(
        currentSort: _currentSort,
        onSortChanged: (sortOption) {
          setState(() {
            _currentSort = sortOption;
          });
          _sortProviders();
        },
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _activeFilters.clear();
      _searchQuery = '';
      _searchController.clear();
    });
    _applyFiltersAndSearch();
  }

  Future<void> _refreshProviders() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _initializeData();

    setState(() {
      _isRefreshing = false;
    });

    Fluttertoast.showToast(
      msg: "Services updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _toggleFavorite(int providerId) {
    setState(() {
      if (_favoriteProviders.contains(providerId)) {
        _favoriteProviders.remove(providerId);
        Fluttertoast.showToast(
          msg: "Removed from favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        _favoriteProviders.add(providerId);
        Fluttertoast.showToast(
          msg: "Added to favorites",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  void _callProvider(Map<String, dynamic> provider) {
    final phone = provider['phone'] ?? '';
    Fluttertoast.showToast(
      msg: "Calling $phone",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _getDirections(Map<String, dynamic> provider) {
    final location = provider['location'] ?? '';
    Fluttertoast.showToast(
      msg: "Getting directions to $location",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _navigateToProviderDetail(Map<String, dynamic> provider) {
    Navigator.pushNamed(context, '/pet-center-detail-screen');
  }

  bool get _hasActiveFilters {
    return _activeFilters.isNotEmpty &&
        ((_activeFilters['minRating'] != null &&
                _activeFilters['minRating'] > 0.0) ||
            (_activeFilters['maxDistance'] != null &&
                _activeFilters['maxDistance'] < 50.0) ||
            (_activeFilters['facilityTypes'] != null &&
                (_activeFilters['facilityTypes'] as List).isNotEmpty) ||
            (_activeFilters['petTypes'] != null &&
                (_activeFilters['petTypes'] as List).isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar.search(
        title: 'Pet Services',
        onSearchPressed: () {
          // Search functionality is handled by the search bar widget
        },
        onFilterPressed: _showFilterBottomSheet,
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBarWidget(
            initialQuery: _searchQuery,
            onSearchChanged: _onSearchChanged,
            onFilterPressed: _showFilterBottomSheet,
            hasActiveFilters: _hasActiveFilters,
          ),

          // Results Header
          if (!_isLoading) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Row(
                children: [
                  Text(
                    '${_filteredProviders.length} services found',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _showSortBottomSheet,
                    icon: CustomIconWidget(
                      iconName: 'sort',
                      color: colorScheme.primary,
                      size: 16,
                    ),
                    label: Text(
                      _getSortLabel(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Content
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _filteredProviders.isEmpty
                    ? _buildEmptyState()
                    : _buildProvidersList(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar.services(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSortBottomSheet,
        tooltip: 'Sort services',
        child: CustomIconWidget(
          iconName: 'sort',
          color: theme.floatingActionButtonTheme.foregroundColor ??
              colorScheme.onPrimary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(3.w),
              height: 25.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 2.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              width: 60.w,
                              height: 1.5.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    if (_searchQuery.isNotEmpty || _hasActiveFilters) {
      return EmptyStateWidget.noResults(
        onClearFilters: _clearFilters,
      );
    } else {
      return EmptyStateWidget.noServices(
        onRefresh: _refreshProviders,
      );
    }
  }

  Widget _buildProvidersList() {
    return RefreshIndicator(
      onRefresh: _refreshProviders,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        itemCount: _filteredProviders.length,
        itemBuilder: (context, index) {
          final provider = _filteredProviders[index];
          final providerId = provider['id'] as int;

          return ServiceProviderCard(
            provider: provider,
            isFavorite: _favoriteProviders.contains(providerId),
            onTap: () => _navigateToProviderDetail(provider),
            onCall: () => _callProvider(provider),
            onDirections: () => _getDirections(provider),
            onFavorite: () => _toggleFavorite(providerId),
          );
        },
      ),
    );
  }

  String _getSortLabel() {
    switch (_currentSort) {
      case SortOption.distance:
        return 'Distance';
      case SortOption.rating:
        return 'Rating';
      case SortOption.availability:
        return 'Availability';
      case SortOption.price:
        return 'Price';
    }
  }
}