import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/track_train/controllers/track_train_controller.dart';

class TrackTrainView extends GetView<TrackTrainController> {
  const TrackTrainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Cinematic background
          Positioned.fill(
            child: Image.asset('assets/route_bg.png', fit: BoxFit.cover),
          ),
          // Dark overlay gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── PINNED HEADER ──
                _buildHeader(),
                // ── SCROLLABLE BODY ──
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 100.h),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Live status badge
                        _buildLiveStatusBanner(),
                        SizedBox(height: 20.h),
                        // Main selection card
                        _buildSelectionCard(),
                      ],
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

  // ── HEADER ──────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Icon badge
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2C9E6A),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2C9E6A).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.train_rounded, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Track Train',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
              Text(
                'Live tracking & platform info',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.75),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Notification / help
          Container(
            height: 42.h,
            width: 42.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Icon(Icons.help_outline_rounded, color: Colors.white, size: 20.sp),
          ),
        ],
      ),
    );
  }

  // ── LIVE STATUS BANNER ───────────────────────────────────────
  Widget _buildLiveStatusBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              // Pulsing green dot
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF4CAF50),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                '48 trains currently active on the network',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'LIVE',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4CAF50),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── MAIN SELECTION CARD ──────────────────────────────────────
  Widget _buildSelectionCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Icon(Icons.route_rounded, color: Color(0xFF2C9E6A), size: 18),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Plan Your Journey',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Train selector
              _buildSectionLabel('Select Train', Icons.train_rounded, const Color(0xFF2C9E6A)),
              SizedBox(height: 10.h),
              _buildTrainDropdown(),
              SizedBox(height: 20.h),

              // Route visual
              _buildRouteLineWidget(),
              SizedBox(height: 20.h),

              // Track button
              _buildTrackButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ── SECTION LABEL ────────────────────────────────────────────
  Widget _buildSectionLabel(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: color),
        SizedBox(width: 6.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  // ── TRAIN DROPDOWN ───────────────────────────────────────────
  Widget _buildTrainDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2C9E6A).withOpacity(0.4)),
      ),
      child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: controller.selectedTrain.value,
              decoration: const InputDecoration(border: InputBorder.none),
              icon: const Icon(Icons.expand_more_rounded, color: Color(0xFF2C9E6A)),
              isExpanded: true,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A4D2E),
              ),
              items: controller.allTrains.map((train) {
                return DropdownMenuItem(
                  value: train,
                  child: Row(
                    children: [
                      const Icon(Icons.train_outlined, size: 16, color: Color(0xFF2C9E6A)),
                      SizedBox(width: 8.w),
                      Text(train),
                    ],
                  ),
                );
              }).toList(),
              onChanged: controller.selectTrain,
            ),
          )),
    );
  }

  // ── ROUTE LINE WIDGET ────────────────────────────────────────
  Widget _buildRouteLineWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // From station
        _buildSectionLabel('From Station', Icons.trip_origin_rounded, const Color(0xFF2C9E6A)),
        SizedBox(height: 8.h),
        _buildStationField(
          hint: 'E.g. Kamalapur',
          icon: Icons.trip_origin_rounded,
          iconColor: const Color(0xFF2C9E6A),
          textController: controller.currentStationController,
          isExpanded: controller.isCurrentExpanded,
          onToggle: controller.toggleCurrentExpansion,
          stations: controller.filteredCurrentStations,
          selectedStation: controller.currentStation,
          onSelect: controller.selectCurrentStation,
        ),

        // Route connector
        Padding(
          padding: EdgeInsets.only(left: 18.w, top: 4.h, bottom: 4.h),
          child: Column(
            children: List.generate(
              4,
              (i) => Container(
                height: 5,
                width: 2,
                margin: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),

        // To station
        _buildSectionLabel('To Station', Icons.location_on_rounded, const Color(0xFF1565C0)),
        SizedBox(height: 8.h),
        _buildStationField(
          hint: 'E.g. Dhaka Airport',
          icon: Icons.location_on_rounded,
          iconColor: const Color(0xFF1565C0),
          textController: controller.targetStationController,
          isExpanded: controller.isTargetExpanded,
          onToggle: controller.toggleTargetExpansion,
          stations: controller.filteredTargetStations,
          selectedStation: controller.targetStation,
          onSelect: controller.selectTargetStation,
        ),
      ],
    );
  }

  // ── STATION FIELD ────────────────────────────────────────────
  Widget _buildStationField({
    required String hint,
    required IconData icon,
    required Color iconColor,
    required TextEditingController textController,
    required RxBool isExpanded,
    required VoidCallback onToggle,
    required RxList<String> stations,
    required RxString selectedStation,
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              // Left icon
              Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Icon(icon, color: iconColor, size: 18.sp),
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  onTap: () {
                    if (!isExpanded.value) onToggle();
                  },
                  style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF1A1A2E)),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 13.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  ),
                ),
              ),
              Obx(() => GestureDetector(
                    onTap: onToggle,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: AnimatedRotation(
                        turns: isExpanded.value ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey.shade500, size: 20.sp),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Obx(() => AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              child: isExpanded.value
                  ? Container(
                      margin: EdgeInsets.only(top: 6.h),
                      constraints: BoxConstraints(maxHeight: 160.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        shrinkWrap: true,
                        itemCount: stations.length,
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: Colors.grey.shade50),
                        itemBuilder: (context, index) {
                          final station = stations[index];
                          final isSelected = selectedStation.value == station;
                          return InkWell(
                            onTap: () => onSelect(station),
                            borderRadius: BorderRadius.circular(8.r),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 11.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFE8F5E9)
                                    : Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.check_circle_rounded
                                        : Icons.radio_button_unchecked_rounded,
                                    size: 16.sp,
                                    color: isSelected
                                        ? iconColor
                                        : Colors.grey.shade400,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    station,
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: isSelected
                                          ? iconColor
                                          : Colors.black87,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            )),
      ],
    );
  }

  // ── TRACK BUTTON ─────────────────────────────────────────────
  Widget _buildTrackButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: controller.onTrack,
        icon: const Icon(Icons.location_searching_rounded, size: 20),
        label: Text(
          'Track Live Now',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C9E6A),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          shadowColor: const Color(0xFF2C9E6A).withOpacity(0.4),
        ),
      ),
    );
  }
}
