import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: NestedScrollView(
        // Keeps the header pinned while body scrolls
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPersistentHeader(
            pinned: true,
            delegate: _PinnedHeaderDelegate(controller: controller),
          ),
        ],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner
              _buildHeroBanner(),
              SizedBox(height: 24.h),
              // Section: Quick Actions
              _buildSectionTitle('Quick Actions'),
              SizedBox(height: 12.h),
              _buildQuickActions(),
              SizedBox(height: 24.h),
              // Section: Feature Cards
              _buildSectionTitle('Explore Features'),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildShareLocationCard(),
                    SizedBox(height: 16.h),
                    _buildTrackCard(),
                    SizedBox(height: 16.h),
                    _buildRailAICard(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── SECTION TITLE ────────────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1A2E),
        ),
      ),
    );
  }

  // ─── HERO BANNER ──────────────────────────────────────
  Widget _buildHeroBanner() {
    return Container(
      height: 200.h,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        image: const DecorationImage(
          image: AssetImage('assets/home_banner.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C9E6A).withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withOpacity(0.65),
              Colors.black.withOpacity(0.15),
            ],
          ),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2C9E6A),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '🚆  Bangladesh Railway',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Travel Smarter\nWith Train Kotai',
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.25,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Track trains, share your journey,\nand unlock rewards.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── QUICK ACTIONS ROW ────────────────────────────────
  Widget _buildQuickActions() {
    return SizedBox(
      height: 100.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildQuickActionChip(
            icon: Icons.podcasts_rounded,
            label: 'Share Location',
            color: const Color(0xFF2C9E6A),
            onTap: controller.onShareLocation,
          ),
          _buildQuickActionChip(
            icon: Icons.location_on_rounded,
            label: 'Track Train',
            color: const Color(0xFF1565C0),
            onTap: controller.onTrack,
          ),
          _buildQuickActionChip(
            icon: Icons.auto_awesome_rounded,
            label: 'Rail AI',
            color: const Color(0xFF6A1B9A),
            onTap: controller.onChatAI,
          ),
          _buildQuickActionChip(
            icon: Icons.stars_rounded,
            label: 'My Coins',
            color: const Color(0xFFF57F17),
            onTap: controller.addCoins,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionChip({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          children: [
            Container(
              height: 58.h,
              width: 58.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.25), width: 1.5),
              ),
              child: Icon(icon, color: color, size: 26.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1A2E),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── SHARE LOCATION CARD ──────────────────────────────
  Widget _buildShareLocationCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon block
          Container(
            height: 52.h,
            width: 52.w,
            decoration: BoxDecoration(
              color: const Color(0xFF2C9E6A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Icon(
              Icons.podcasts_rounded,
              color: Color(0xFF2C9E6A),
              size: 28,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share Location',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Earn coins by broadcasting your live train position to other passengers.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.h),
                // Progress
                Row(
                  children: [
                    Obx(() => Text(
                          controller.shareCountText.value,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2C9E6A),
                          ),
                        )),
                    const Spacer(),
                    Text(
                      'Daily Goal',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Obx(() => ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: LinearProgressIndicator(
                        value: controller.shareProgress.value,
                        backgroundColor: Colors.grey.shade100,
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF2C9E6A)),
                        minHeight: 8.h,
                      ),
                    )),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.onShareLocation,
                    icon: const Icon(Icons.podcasts_rounded, size: 16),
                    label: Text(
                      'Start Sharing',
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C9E6A),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── TRACK TRAIN CARD ────────────────────────────────
  Widget _buildTrackCard() {
    return GestureDetector(
      onTap: controller.onTrack,
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          image: const DecorationImage(
            image: AssetImage('assets/home_two.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xFF1565C0).withOpacity(0.75),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: EdgeInsets.all(22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                    ),
                    child: Text(
                      '🔴  LIVE',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Track Live Train\nLocation',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Track Now  →',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: const Color(0xFF1565C0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── RAIL AI CARD ─────────────────────────────────────
  Widget _buildRailAICard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF2D1B69)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A1B9A).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: 60,
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9C27B0).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: const Color(0xFF9C27B0).withOpacity(0.6)),
                        ),
                        child: Text(
                          '✨  AI Powered',
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFCE93D8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Rail AI',
                        style: GoogleFonts.inter(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Smart Railway\nInsights',
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.7),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: controller.onChatAI,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9C27B0),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 15),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: Text(
                                  'Chat with Rail AI',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // AI Image — constrained width to prevent overflow
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 110.w),
                  child: Image.asset(
                    'assets/aiImage.png',
                    height: 140.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── PINNED SLIVER HEADER DELEGATE ───────────────────────
class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final HomeController controller;

  _PinnedHeaderDelegate({required this.controller});

  @override
  double get minExtent => 90;
  @override
  double get maxExtent => 90;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _PinnedHeader(controller: controller);
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) => false;
}

class _PinnedHeader extends StatelessWidget {
  final HomeController controller;
  const _PinnedHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Row(
            children: [
              // Avatar
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C9E6A), Color(0xFF1B5E38)],
                  ),
                ),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=jane'),
                ),
              ),
              SizedBox(width: 12.w),
              // Greeting
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Good Morning 👋',
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        color: Colors.grey.shade500,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Al Muntakim',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A2E),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              // Coin pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFFFFE082)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.stars_rounded, color: Color(0xFFFFC107), size: 18),
                    SizedBox(width: 4.w),
                    Obx(() => Text(
                          '${controller.coins.value}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: const Color(0xFF5D4037),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Notification bell
              _buildIconButton(Icons.notifications_none_outlined, hasBadge: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {bool hasBadge = false}) {
    return Stack(
      children: [
        Container(
          height: 42.h,
          width: 42.w,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F8),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, color: const Color(0xFF1A1A2E), size: 20),
        ),
        if (hasBadge)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
