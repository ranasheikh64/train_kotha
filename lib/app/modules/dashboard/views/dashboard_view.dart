import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:train_kotai/app/modules/home/views/home_view.dart';
import 'package:train_kotai/app/modules/track_train/views/track_train_view.dart';
import 'package:train_kotai/app/modules/train_ai/views/train_ai_view.dart';
import 'package:train_kotai/app/modules/feed/views/feed_view.dart';
import 'package:train_kotai/app/modules/profile/views/profile_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(), // Only change via bottom bar
        children: const [
          HomeView(),
          TrackTrainView(),
          TrainAIView(),
          FeedView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: const CustomAnimatedBottomBar(),
    );
  }
}

class CustomAnimatedBottomBar extends GetView<DashboardController> {
  const CustomAnimatedBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.train_outlined, Icons.train_rounded, 'Track'),
                _buildNavItem(2, Icons.auto_awesome_outlined, Icons.auto_awesome_rounded, 'Train AI'),
                _buildNavItem(3, Icons.rss_feed_outlined, Icons.rss_feed_rounded, 'Feed'),
                _buildNavItem(4, Icons.person_outline, Icons.person_rounded, 'Profile'),
              ],
            )),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    final isSelected = controller.selectedIndex.value == index;
    final color = isSelected ? const Color(0xFF2C9E6A) : Colors.grey.shade400;

    return InkWell(
      onTap: () => controller.changeTab(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isSelected ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: color,
                size: 26.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
            // Indicator Dot
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(top: 4.h),
              height: 4.h,
              width: isSelected ? 4.w : 0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabPlaceholder extends StatelessWidget {
  final String title;
  final IconData icon;

  const TabPlaceholder({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.shade200),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
