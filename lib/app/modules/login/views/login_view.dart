import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:train_kotai/app/modules/login/controllers/login_controller.dart';
import 'package:train_kotai/app/routes/app_pages.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';
import 'package:train_kotai/app/widgets/custom_text_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
              SizedBox(height: 40.h),

              // Logo
              Image.asset(
                'assets/splash_screen_image.png',
                height: 120.h,
                fit: BoxFit.contain,
              ),

              SizedBox(height: 24.h),

              // Welcome Text
              Text(
                'Welcome Back',
                style: GoogleFonts.inter(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Login to your account',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.grey.shade500,
                ),
              ),

              SizedBox(height: 32.h),

              // Email Field
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),

              SizedBox(height: 24.h),

              // Password Field
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: controller.passwordController,
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 16.h),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: controller.toggleRememberMe,
                          activeColor: const Color(0xFF2C9E6A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      Text(
                        'Remember Me',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Login Button
              Obx(
                () => CustomButton(
                  text: 'Log In',
                  onPressed: controller.login,
                  isLoading: controller.isLoading.value,
                ),
              ),

              SizedBox(height: 24.h),

              // or Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'or',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade200)),
                ],
              ),

              SizedBox(height: 24.h),

              // Social Login Button
              CustomButton(
                text: 'Continue with Google',
                onPressed: controller.loginWithGoogle,
                backgroundColor: Colors.white,
                textColor: const Color(0xFF1A1A1A),
                borderRadius: 16.r,
                leading: Icon(
                  Icons.g_mobiledata,
                  size: 30.sp,
                  color: Colors.blue,
                ), // Placeholder for Google Icon
              ),

              SizedBox(height: 32.h),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.SIGNUP),
                    child: Text(
                      'Sign up here',
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
