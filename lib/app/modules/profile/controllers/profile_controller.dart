import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final userName = 'Al Muntakim'.obs;
  final userCoins = '1,240'.obs;
  final userLocation = 'Dhaka, BD'.obs;
  final userTrips = '24'.obs;

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Get.offAllNamed(Routes.LOGIN),
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
        content: const Text(
          'This action is permanent and cannot be undone. All your data and coins will be lost forever.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              // Delete logic here
              Get.offAllNamed(Routes.SIGNUP);
            },
            child: const Text('Delete permanently', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void updateProfile() {
    Get.snackbar('Notice', 'Update Profile screen coming soon!', snackPosition: SnackPosition.TOP);
  }

  void changePassword() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }
}
