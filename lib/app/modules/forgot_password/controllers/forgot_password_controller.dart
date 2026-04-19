import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;
  final emailError = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void sendCode() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emailError.value = 'Please enter your email';
      return;
    }

    // Reset error
    emailError.value = '';
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // For demonstration, let's trigger the error state shown in the screenshot
    // if the email is "test@error.com" or just always for this demo
    if (email == "error@test.com") {
      emailError.value = 'This email is not linked to this account';
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.toNamed(Routes.VERIFY_OTP);
      Get.snackbar(
        'Success',
        'Verification code sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    }
  }
}
