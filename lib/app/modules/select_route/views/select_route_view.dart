import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/select_route/controllers/select_route_controller.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';

class SelectRouteView extends GetView<SelectRouteController> {
  const SelectRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/route_bg.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Return a colorful gradient if image not found
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Overlay
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),

            SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                            ),
                          ),
                        ),
                        Text(
                          'Select Your Route',
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 48), // Spacer
                      ],
                    ),
                  ),

                  // const Spacer(),

                  // Selection Card
                  Container(
                    height: 0.7.sh,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Your Route',
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Your selected route for feed & posts',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Search Bar
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: TextField(
                            controller: controller.searchController,
                            decoration: InputDecoration(
                              hintText: 'Search routes...',
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey.shade400,
                              ),
                              hintStyle: GoogleFonts.inter(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Routes List
                        Expanded(
                          child: Obx(
                            () => ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: controller.filteredRoutes.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 12.h),
                              itemBuilder: (context, index) {
                                final route = controller.filteredRoutes[index];
                                final isSelected =
                                    controller.selectedRouteIndex.value ==
                                    index;

                                return GestureDetector(
                                  onTap: () => controller.selectRoute(index),
                                  child: Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFE8F5E9)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF2C9E6A)
                                            : Colors.grey.shade200,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            route.from,
                                            style: GoogleFonts.inter(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? const Color(0xFF2C9E6A)
                                                  : Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8.w),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF0FDF4),
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.swap_horiz,
                                            color: Color(0xFF2C9E6A),
                                            size: 20,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            route.to,
                                            textAlign: TextAlign.end,
                                            style: GoogleFonts.inter(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? const Color(0xFF2C9E6A)
                                                  : Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Submit Button
                        CustomButton(
                          text: 'Go To Home Screen',
                          onPressed: controller.goToHome,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
