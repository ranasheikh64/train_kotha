import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:train_kotai/app/modules/map_tracking/controllers/map_tracking_controller.dart';

class MapTrackingView extends GetView<MapTrackingController> {
  const MapTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // ── GOOGLE MAP (FULL SCREEN) ──────────────────────────
          Obx(() => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.startLocation,
                  zoom: 13,
                ),
                onMapCreated: controller.onMapCreated,
                markers: controller.markers.toSet(),
                polylines: controller.polylines.toSet(),
                myLocationEnabled: controller.isPermissionGranted.value,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
              )),

          // ── TOP GRADIENT OVERLAY ──────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 160.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── TOP BAR ──────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  // Back button
                  _buildMapButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Get.back(),
                  ),
                  SizedBox(width: 12.w),
                  // Train name pill
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(color: Color(0xFF4CAF50), blurRadius: 5, spreadRadius: 1),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Obx(() => Text(
                                    controller.trainName.value,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )),
                              SizedBox(width: 6.w),
                              Obx(() => Text(
                                    controller.trainNo.value,
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Share button
                  _buildMapButton(
                    icon: Icons.share_outlined,
                    onTap: controller.shareLocation,
                  ),
                ],
              ),
            ),
          ),

          // ── RIGHT SIDE FABs ───────────────────────────────────
          Positioned(
            right: 16.w,
            bottom: 310.h,
            child: Column(
              children: [
                // Speedometer
                _buildSpeedometer(),
                SizedBox(height: 12.h),
                // My location
                _buildMapButton(
                  icon: Icons.my_location_rounded,
                  onTap: () {},
                  size: 48,
                ),
              ],
            ),
          ),

          // ── DRAGGABLE BOTTOM SHEET ────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.38,
            maxChildSize: 0.88,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 30,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
                          height: 4.h,
                          width: 44.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // ── ETA + STATS ROW ───────────────────────
                      _buildStatsRow(),
                      SizedBox(height: 20.h),

                      // ── ROUTE PROGRESS BAR ────────────────────
                      _buildRouteProgressBar(),
                      SizedBox(height: 24.h),

                      // Platform info
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _buildInfoTile(),
                      ),
                      SizedBox(height: 20.h),

                      // Timeline section label
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'Station Timeline',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // ── TIMELINE ─────────────────────────────
                      _buildTimeline(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── MAP BUTTON ────────────────────────────────────────────────
  Widget _buildMapButton({
    required IconData icon,
    required VoidCallback onTap,
    double size = 46,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.h,
        width: size.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20.sp, color: const Color(0xFF1A1A2E)),
      ),
    );
  }

  // ── SPEEDOMETER ───────────────────────────────────────────────
  Widget _buildSpeedometer() {
    return Container(
      height: 72.h,
      width: 72.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C9E6A).withOpacity(0.3),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFF2C9E6A), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text(
                controller.speed.value.split(' ')[0],
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C9E6A),
                  height: 1,
                ),
              )),
          Text(
            'km/h',
            style: GoogleFonts.inter(
              fontSize: 9.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── STATS ROW ─────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // ETA chip
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2C9E6A),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Text(
                    'ETA',
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: Colors.white.withOpacity(0.8),
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Obx(() => Text(
                        controller.eta.value,
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Speed stat
          Expanded(
            child: _buildStatCard(
              label: 'Speed',
              value: '60',
              unit: 'km/h',
              icon: Icons.speed_rounded,
              color: const Color(0xFF1565C0),
            ),
          ),
          SizedBox(width: 10.w),
          // Delay stat
          Expanded(
            child: _buildStatCard(
              label: 'Delay',
              value: '5',
              unit: 'min',
              icon: Icons.timer_outlined,
              color: const Color(0xFFF57F17),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
              height: 1,
            ),
          ),
          Text(
            unit,
            style: GoogleFonts.inter(
              fontSize: 9.sp,
              color: color.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // ── ROUTE PROGRESS BAR ────────────────────────────────────────
  Widget _buildRouteProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRouteEndpoint(
                  label: 'FROM',
                  station: controller.prevStation.value,
                  icon: Icons.trip_origin_rounded,
                  color: const Color(0xFF2C9E6A),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C9E6A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '48%',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C9E6A),
                    ),
                  ),
                ),
                _buildRouteEndpoint(
                  label: 'TO',
                  station: controller.nextStation.value,
                  icon: Icons.location_on_rounded,
                  color: const Color(0xFFE53935),
                  isRight: true,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: LinearProgressIndicator(
                value: 0.48,
                minHeight: 8.h,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF2C9E6A)),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.circle, size: 8.sp, color: const Color(0xFF2C9E6A)),
                SizedBox(width: 4.w),
                Text(
                  'En route · Next stop: Airport',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteEndpoint({
    required String label,
    required String station,
    required IconData icon,
    required Color color,
    bool isRight = false,
  }) {
    return Column(
      crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: isRight
              ? [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(icon, size: 11.sp, color: color),
                ]
              : [
                  Icon(icon, size: 11.sp, color: color),
                  SizedBox(width: 4.w),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                      letterSpacing: 1,
                    ),
                  ),
                ],
        ),
        SizedBox(height: 2.h),
        Text(
          station,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  // ── PLATFORM INFO TILE ────────────────────────────────────────
  Widget _buildInfoTile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFFF57C00), size: 18),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Arriving at Airport — Platform 2 in approximately 8 minutes',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF5D4037),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── TIMELINE ──────────────────────────────────────────────────
  Widget _buildTimeline() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.timeline.length,
        itemBuilder: (context, index) {
          final stop = controller.timeline[index];
          final isLast = index == controller.timeline.length - 1;
          final isCurrent = stop.status == 'current';
          final isVisited = stop.status == 'visited';

          final Color dotColor = isCurrent
              ? const Color(0xFF2C9E6A)
              : isVisited
                  ? const Color(0xFF2C9E6A).withOpacity(0.5)
                  : Colors.grey.shade300;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── TIME ──
                SizedBox(
                  width: 62.w,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stop.arrivalTime,
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            color: isCurrent || isVisited ? Colors.black87 : Colors.grey.shade400,
                            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        Text(
                          stop.departureTime,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── TRACK ──
                Column(
                  children: [
                    SizedBox(height: 4.h),
                    // Dot
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (isCurrent)
                          Container(
                            height: 22.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF2C9E6A).withOpacity(0.15),
                            ),
                          ),
                        Container(
                          height: isCurrent ? 14.h : 12.h,
                          width: isCurrent ? 14.w : 12.w,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                            border: isVisited || isCurrent
                                ? null
                                : Border.all(color: Colors.grey.shade300, width: 2),
                            boxShadow: isCurrent
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF2C9E6A).withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      ],
                    ),
                    // Line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.w,
                          color: isVisited
                              ? const Color(0xFF2C9E6A).withOpacity(0.4)
                              : Colors.grey.shade200,
                        ),
                      ),
                  ],
                ),

                SizedBox(width: 14.w),

                // ── STATION INFO ──
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h, top: 2.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stop.name,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                                  color: isCurrent || isVisited ? const Color(0xFF1A1A2E) : Colors.grey.shade400,
                                ),
                              ),
                              if (isCurrent)
                                Container(
                                  margin: EdgeInsets.only(top: 4.h),
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2C9E6A),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    '● EN ROUTE',
                                    style: GoogleFonts.inter(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              if (isLast)
                                Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Text(
                                    'Est. arrival: 12:15 PM',
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: const Color(0xFF2C9E6A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (isVisited)
                          Icon(Icons.check_circle_rounded,
                              color: const Color(0xFF2C9E6A), size: 16.sp),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
