import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  /// Navigate to home screen after splash animation
  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.serviceListing);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo with animations
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20.0,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  'assets/images/img_app_logo.svg',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.contain,
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 300.ms)
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 1000.ms,
                  delay: 300.ms,
                  curve: Curves.elasticOut,
                )
                .shimmer(
                  duration: 2000.ms,
                  delay: 1200.ms,
                  color: Colors.white.withValues(alpha: 0.3),
                ),

            SizedBox(height: 6.h),

            // App Title with staggered animation
            Column(
              children: [
                Text(
                  'PetCare',
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(
                      begin: 0.3,
                      end: 0.0,
                      duration: 800.ms,
                      delay: 1000.ms,
                      curve: Curves.easeOutQuart,
                    ),
                SizedBox(height: 1.h),
                Text(
                  'Finder',
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                    letterSpacing: 2.0,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 1300.ms).slideY(
                      begin: 0.3,
                      end: 0.0,
                      duration: 800.ms,
                      delay: 1300.ms,
                      curve: Curves.easeOutQuart,
                    ),
              ],
            ),

            SizedBox(height: 3.h),

            // Tagline with typewriter effect
            Text(
              'Your Pet\'s Perfect Care Companion',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.5,
              ),
            ).animate().fadeIn(duration: 800.ms, delay: 1600.ms).slideY(
                  begin: 0.2,
                  end: 0.0,
                  duration: 600.ms,
                  delay: 1600.ms,
                ),

            SizedBox(height: 8.h),

            // Loading indicator with pulsing animation
            Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleX(
                    begin: 0.0,
                    end: 1.0,
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  )
                  .then(delay: 200.ms)
                  .scaleX(
                    begin: 1.0,
                    end: 0.0,
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  ),
            ).animate().fadeIn(duration: 500.ms, delay: 2200.ms),

            SizedBox(height: 2.h),

            // Loading text with subtle animation
            Text(
              'Loading...',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms, delay: 2400.ms)
                .then(delay: 200.ms)
                .animate(onPlay: (controller) => controller.repeat())
                .fade(
                  begin: 1.0,
                  end: 0.5,
                  duration: 1000.ms,
                )
                .then()
                .fade(
                  begin: 0.5,
                  end: 1.0,
                  duration: 1000.ms,
                ),
          ],
        ),
      ),
    );
  }
}
