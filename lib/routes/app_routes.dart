import 'package:flutter/material.dart';
import '../presentation/service_listing_screen/service_listing_screen.dart';
import '../presentation/pet_center_detail_screen/pet_center_detail_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splash = '/splash';
  static const String serviceListing = '/service-listing-screen';
  static const String petCenterDetail = '/pet-center-detail-screen';
  static const String home = '/home-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    serviceListing: (context) => const ServiceListingScreen(),
    petCenterDetail: (context) => const PetCenterDetailScreen(),
    home: (context) => const HomeScreen(),
    // TODO: Add your other routes here
  };
}
