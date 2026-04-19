import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cinematic Background Image
          Positioned.fill(
            child: Image.asset('assets/route_bg.png', fit: BoxFit.cover),
          ),

          // Top dark gradient for header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 380.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.65),
                    Colors.black.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // // Bottom white sheet
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   height: 430.h,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          //     ),
          //   ),
          // ),

          // Single scrollable content layer
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                SliverToBoxAdapter(child: _buildStatsRow()),
                SliverToBoxAdapter(child: SizedBox(height: 36.h)),
                SliverToBoxAdapter(child: _buildMenuSheet()),
                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ──────────── HEADER ────────────
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        children: [
          // Avatar with glowing ring
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow ring
              Container(
                height: 116.h,
                width: 116.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF2C9E6A).withOpacity(0.8),
                      Colors.white.withOpacity(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2C9E6A).withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
              // White separator ring
              Container(
                height: 110.h,
                width: 110.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: const Color(0xFFE8F5E9),
                ),
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    size: 56.sp,
                    color: const Color(0xFF2C9E6A),
                  ),
                ),
              ),
              // Edit badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2C9E6A),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Obx(
            () => Text(
              controller.userName.value,
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Train Traveler',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white.withOpacity(0.75),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────── GLASS STATS ROW ────────────
  Widget _buildStatsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: Colors.black.withOpacity(0.20),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '🪙',
                    controller.userCoins,
                    'Total Coins',
                  ),
                ),
                _buildVerticalDivider(),
                Expanded(
                  child: _buildStatItem(
                    '📍',
                    controller.userLocation,
                    'Location',
                  ),
                ),
                _buildVerticalDivider(),
                Expanded(
                  child: _buildStatItem('🚂', controller.userTrips, 'Trips'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40.h,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  Widget _buildStatItem(String emoji, RxString value, String label) {
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: 18.sp)),
        SizedBox(height: 4.h),
        Obx(
          () => Text(
            value.value,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  // ──────────── MENU SHEET ────────────
  Widget _buildMenuSheet() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          _buildGroupLabel('Account'),
          _buildMenuTile(
            icon: Icons.person_outline_rounded,
            label: 'Update Profile',
            subtitle: 'Edit your name and details',
            iconBg: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2C9E6A),
            onTap: controller.updateProfile,
          ),
          _buildMenuTile(
            icon: Icons.lock_outline_rounded,
            label: 'Change Password',
            subtitle: 'Update your password',
            iconBg: const Color(0xFFE3F2FD),
            iconColor: Colors.blue,
            onTap: controller.changePassword,
          ),
          _buildMenuTile(
            icon: Icons.shield_outlined,
            label: 'Privacy Policy',
            subtitle: 'How we use your data',
            iconBg: const Color(0xFFF3E5F5),
            iconColor: Colors.purple,
          ),
          SizedBox(height: 10.h),
          _buildGroupLabel('Danger Zone'),
          _buildMenuTile(
            icon: Icons.logout_rounded,
            label: 'Logout',
            subtitle: 'Sign out of your account',
            iconBg: const Color(0xFFFFF3E0),
            iconColor: Colors.orange,
            onTap: controller.logout,
            showDivider: false,
          ),
          _buildMenuTile(
            icon: Icons.delete_forever_rounded,
            label: 'Delete Account',
            subtitle: 'Permanently remove your account',
            iconBg: const Color(0xFFFFEBEE),
            iconColor: Colors.red,
            trailingColor: Colors.red,
            onTap: controller.deleteAccount,
            showDivider: false,
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildGroupLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 4.h, top: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade400,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color iconBg,
    required Color iconColor,
    Color? trailingColor,
    VoidCallback? onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap ?? () => _showActionSheet(label),
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(icon, color: iconColor, size: 22.sp),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: trailingColor ?? Colors.black87,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey.shade300,
                  size: 22.sp,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),
      ],
    );
  }

  // ──────────── GLASSY MODAL BOTTOM SHEET ────────────
  void _showActionSheet(String title) {
    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4.h,
                  width: 40.w,
                  margin: EdgeInsets.only(bottom: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'This feature will be available soon.',
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C9E6A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'Got it',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
