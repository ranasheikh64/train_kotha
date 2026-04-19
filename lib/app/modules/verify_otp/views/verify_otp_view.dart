import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:train_kotai/app/modules/verify_otp/controllers/verify_otp_controller.dart';
import 'package:train_kotai/app/widgets/custom_button.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    // Customizing pinput theme
    final defaultPinTheme = PinTheme(
      width: 64.w,
      height: 64.h,
      textStyle: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF1A1A1A),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: const Color(0xFF2C9E6A)),
      ),
    );

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
                'Enter 4 Digit Code',
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
                'Enter the 4 digit code sent to your email',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.grey.shade500,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Countdown Timer
              Obx(() => Text(
                controller.timerText.value,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C9E6A),
                ),
              )),
              
              SizedBox(height: 32.h),
              
              // OTP Input
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onChanged: (value) => controller.otpCode.value = value,
                onCompleted: (pin) => controller.submitCode(),
                separatorBuilder: (index) => SizedBox(width: 16.w),
              ),
              
              SizedBox(height: 48.h),
              
              // Submit Button
              Obx(() => CustomButton(
                text: 'Submit Code',
                onPressed: controller.submitCode,
                isLoading: controller.isLoading.value,
              )),
              
              SizedBox(height: 32.h),
              
              // Resend Code Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Haven\'t got the code yet? ',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.resendCode,
                    child: Text(
                      'Resend Code',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF2C9E6A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
