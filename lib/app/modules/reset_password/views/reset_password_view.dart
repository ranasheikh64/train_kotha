import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/reset_password/controllers/reset_password_controller.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';
import 'package:train_kotai/app/widgets/custom_text_field.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 48.h,
                    width: 48.w,
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
                    child: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Logo
              Image.asset(
                'assets/splash_screen_image.png',
                height: 120.h,
                fit: BoxFit.contain,
              ),
              
              SizedBox(height: 32.h),
              
              // Heading
              Text(
                'Reset Your Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              
              SizedBox(height: 12.h),
              
              // Subheading
              Text(
                'Enter your new password below',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // New Password Field
              CustomTextField(
                hint: 'Write new password',
                controller: controller.passwordController,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),
              
              SizedBox(height: 24.h),
              
              // Confirm Password Field
              CustomTextField(
                hint: 'Confirm new password',
                controller: controller.confirmPasswordController,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),
              
              SizedBox(height: 48.h),
              
              // Save Button
              Obx(() => CustomButton(
                text: 'Save New Password',
                onPressed: controller.saveNewPassword,
                isLoading: controller.isLoading.value,
              )),
              
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
