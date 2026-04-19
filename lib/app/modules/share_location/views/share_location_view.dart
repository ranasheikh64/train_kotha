import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/share_location/controllers/share_location_controller.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';

class ShareLocationView extends GetView<ShareLocationController> {
  const ShareLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        title: Text(
          'Share Location',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              height: 44.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.tune, color: Colors.black),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: Image.asset('assets/route_bg.png', fit: BoxFit.cover),
            ),
            // Content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [
                    SizedBox(height: 80.h),
                    // Spacer(flex: 2),
                    _buildShareLocationCard(),
                    // Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareLocationCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Select Train'),
          SizedBox(height: 12.h),
          _buildTrainDropdown(),

          SizedBox(height: 24.h),
          _buildLabel('Select the station you are in'),
          SizedBox(height: 12.h),
          _buildExpandingStationField(
            hint: 'Write current station...',
            textController: controller.currentStationController,
            isExpanded: controller.isCurrentExpanded,
            onToggle: controller.toggleCurrentExpansion,
            stations: controller.filteredCurrentStations,
            selectedStation: controller.currentStation,
            onSelect: controller.selectCurrentStation,
          ),

          SizedBox(height: 24.h),
          _buildLabel('Select target station'),
          SizedBox(height: 12.h),
          _buildExpandingStationField(
            hint: 'Write target station...',
            textController: controller.targetStationController,
            isExpanded: controller.isTargetExpanded,
            onToggle: controller.toggleTargetExpansion,
            stations: controller.filteredTargetStations,
            selectedStation: controller.targetStation,
            onSelect: controller.selectTargetStation,
          ),

          SizedBox(height: 32.h),
          CustomButton(text: 'Continue', onPressed: controller.onContinue),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildExpandingStationField({
    required String hint,
    required TextEditingController textController,
    required RxBool isExpanded,
    required VoidCallback onToggle,
    required RxList<String> stations,
    required RxString selectedStation,
    required Function(String) onSelect,
  }) {
    return Column(
      children: [
        // Box / Search Field
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    onTap: () {
                      if (!isExpanded.value) onToggle();
                    },
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.inter(color: Colors.grey.shade400),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedRotation(
                    turns: isExpanded.value ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expanding List
        Obx(
          () => AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded.value
                ? Container(
                    margin: EdgeInsets.only(top: 8.h),
                    constraints: BoxConstraints(maxHeight: 150.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: stations.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1, color: Colors.grey.shade50),
                      itemBuilder: (context, index) {
                        final station = stations[index];
                        final isSelected = selectedStation.value == station;

                        return InkWell(
                          onTap: () => onSelect(station),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.w,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFE8F5E9)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                station,
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  color: isSelected
                                      ? const Color(0xFF2C9E6A)
                                      : Colors.black87,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrainDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2C9E6A)),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: controller.selectedTrain.value,
            decoration: const InputDecoration(border: InputBorder.none),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF2C9E6A),
            ),
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C9E6A),
            ),
            items: controller.allTrains.map((train) {
              return DropdownMenuItem(value: train, child: Text(train));
            }).toList(),
            onChanged: controller.selectTrain,
          ),
        ),
      ),
    );
  }
}
