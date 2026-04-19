import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/change_password/controllers/change_password_controller.dart';
import 'package:train_kotai/app/widgets/custom_text_field.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/route_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Dark Overlay for depth
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Back Button & Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.15),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Change Password',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Glassy Input Card
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Secure Your Account',
                              style: GoogleFonts.inter(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Please enter your current and new password below.',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: Color(0xFF4A4A4A),
                              ),
                            ),
                            SizedBox(height: 32.h),
                            
                            CustomTextField(
                              label: 'Old Password',
                              hint: 'Enter your current password',
                              controller: controller.oldPasswordController,
                              isPassword: true,
                              prefixIcon: Icons.lock_open_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            
                            CustomTextField(
                              label: 'New Password',
                              hint: 'Enter new password',
                              controller: controller.newPasswordController,
                              isPassword: true,
                              prefixIcon: Icons.lock_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                if (value.length < 6) return 'At least 6 characters';
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            
                            CustomTextField(
                              label: 'Confirm New Password',
                              hint: 'Retype new password',
                              controller: controller.confirmPasswordController,
                              isPassword: true,
                              prefixIcon: Icons.verified_user_rounded,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                return null;
                              },
                            ),
                            
                            SizedBox(height: 40.h),
                            
                            Obx(() => CustomButton(
                              text: 'Change Password',
                              isLoading: controller.isLoading.value,
                              onPressed: controller.updatePassword,
                            )),
                            
                            SizedBox(height: MediaQuery.of(context).padding.bottom),
                          ],
                        ),
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
}
