import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/add_post/controllers/add_post_controller.dart';

class AddPostView extends GetView<AddPostController> {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundColor: const Color(0xFFE8F5E9),
                        child: Icon(Icons.person, color: Colors.grey.shade400, size: 28.sp),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Al Muntakim',
                            style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Obx(() => controller.selectedLocation.value.isNotEmpty
                              ? Row(
                                  children: [
                                    Icon(Icons.location_on, size: 12.sp, color: const Color(0xFF2C9E6A)),
                                    SizedBox(width: 4.w),
                                    Text(
                                      controller.selectedLocation.value,
                                      style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF2C9E6A)),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Sharing with travelers',
                                  style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey),
                                )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Text Input
                  TextField(
                    controller: controller.contentController,
                    maxLines: null,
                    style: GoogleFonts.inter(fontSize: 18.sp, color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "What's happening on your journey?",
                      hintStyle: GoogleFonts.inter(fontSize: 18.sp, color: Colors.grey.shade400),
                      border: InputBorder.none,
                    ),
                  ),

                  // Image Previews
                  SizedBox(height: 20.h),
                  Obx(() => controller.selectedImages.isEmpty 
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: 200.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectedImages.length,
                            separatorBuilder: (context, index) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Image.file(
                                      controller.selectedImages[index],
                                      height: 200.h,
                                      width: 150.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8.h,
                                    right: 8.w,
                                    child: InkWell(
                                      onTap: () => controller.removeImage(index),
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                        child: const Icon(Icons.close, color: Colors.white, size: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        )),
                ],
              ),
            ),
          ),

          // Bottom Toolbar
          _buildToolbar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Obx(() => ElevatedButton(
                onPressed: controller.isPosting.value ? null : controller.submitPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C9E6A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  elevation: 0,
                ),
                child: controller.isPosting.value 
                    ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Post'),
              )),
        ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildToolbarIcon(Icons.image_outlined, "Gallery", controller.pickImage),
            SizedBox(width: 20.w),
            _buildToolbarIcon(Icons.camera_alt_outlined, "Camera", controller.captureImage),
            SizedBox(width: 20.w),
            _buildToolbarIcon(Icons.location_on_outlined, "Location", controller.pickCurrentLocation),
            const Spacer(),
            Text(
              "Public",
              style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF2C9E6A), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarIcon(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black54, size: 24.sp),
          SizedBox(height: 4.h),
          Text(label, style: GoogleFonts.inter(fontSize: 10.sp, color: Colors.grey)),
        ],
      ),
    );
  }
}
