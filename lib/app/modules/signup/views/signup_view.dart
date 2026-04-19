import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/signup/controllers/signup_controller.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';
import 'package:train_kotai/app/widgets/custom_text_field.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

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
              // // Back Button
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: InkWell(
              //     onTap: () => Get.back(),
              //     child: Container(
              //       height: 48.h,
              //       width: 48.w,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         shape: BoxShape.circle,
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black.withOpacity(0.05),
              //             blurRadius: 10,
              //             offset: const Offset(0, 5),
              //           ),
              //         ],
              //       ),
              //       child: const Icon(Icons.arrow_back_ios_new, size: 18),
              //     ),
              //   ),
              // ),
              SizedBox(height: 24.h),

              // Logo
              Image.asset(
                'assets/splash_screen_image.png',
                height: 100.h,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 24.h),

              // Heading
              Text(
                'Create Account',
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Fill in your details to get started',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.grey.shade500,
                ),
              ),

              SizedBox(height: 32.h),

              // Name Field
              CustomTextField(
                label: 'Name',
                hint: 'Enter your full name',
                controller: controller.nameController,
                prefixIcon: Icons.person_outline,
              ),

              SizedBox(height: 16.h),

              // Email Field
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),

              SizedBox(height: 16.h),

              // Location Field
              CustomTextField(
                label: 'Location',
                hint: 'Enter your location',
                controller: controller.locationController,
                prefixIcon: Icons.location_on_outlined,
              ),

              SizedBox(height: 16.h),

              // Password Field
              CustomTextField(
                label: 'Password',
                hint: 'Create a password',
                controller: controller.passwordController,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 32.h),

              // Sign Up Button
              Obx(
                () => CustomButton(
                  text: 'Sign Up',
                  onPressed: controller.signup,
                  isLoading: controller.isLoading.value,
                ),
              ),

              SizedBox(height: 24.h),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Login',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF2C9E6A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
