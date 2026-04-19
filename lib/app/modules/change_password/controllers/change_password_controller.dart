import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  void updatePassword() {
    if (formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        Get.snackbar(
          'Error',
          'New password and confirmation do not match',
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      isLoading.value = true;
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        Get.back();
        Get.snackbar(
          'Success',
          'Password updated successfully',
          backgroundColor: const Color(0xFF2C9E6A).withOpacity(0.1),
          colorText: const Color(0xFF2C9E6A),
          snackPosition: SnackPosition.TOP,
        );
      });
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
