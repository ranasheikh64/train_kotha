import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';
import 'package:train_kotai/app/widgets/custom_text_field.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
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
                  'Forgot Password',
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),

                SizedBox(height: 12.h),

                // Subheading
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Enter your email address linked to your account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Email Field
                CustomTextField(
                  hint: 'Email',
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),

                // Error Message
                Obx(
                  () => controller.emailError.value.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              controller.emailError.value,
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                SizedBox(height: 32.h),

                // Send Code Button
                Obx(
                  () => CustomButton(
                    text: 'Send Code',
                    onPressed: controller.sendCode,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
