import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    // Basic validation
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    isLoading.value = true;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    Get.offAllNamed(Routes.SELECT_ROUTE);
  }

  void loginWithGoogle() async {
    isLoading.value = true;
    // Simulate Google sign-in
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.offAllNamed(Routes.SELECT_ROUTE);
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }
}
