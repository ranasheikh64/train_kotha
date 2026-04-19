import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:train_kotai/app/data/models/post_model.dart';
import 'package:train_kotai/app/modules/feed/controllers/feed_controller.dart';

class AddPostController extends GetxController {
  final contentController = TextEditingController();
  final selectedImages = <File>[].obs;
  final selectedLocation = ''.obs;
  final isPosting = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  Future<void> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImages.add(File(image.path));
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> pickCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // For a real app, we would reverse geocode this.
      // For now, we'll simulate a station name.
      selectedLocation.value = "Kamalapur Station, Dhaka";
    } catch (e) {
      Get.snackbar('Error', 'Could not get location. Please enable GPS.');
    }
  }

  void submitPost() {
    if (contentController.text.trim().isEmpty && selectedImages.isEmpty) {
      Get.snackbar('Empty Post', 'Please write something or add an image.');
      return;
    }

    isPosting.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: 'Al Muntakim', // Should be from Auth service
        time: 'Just now',
        content: contentController.text,
        localImage: selectedImages.isNotEmpty ? selectedImages.first : null,
        locationName: selectedLocation.value.isNotEmpty ? selectedLocation.value : null,
        likes: 0,
        comments: 0,
        shares: 0,
      );

      Get.find<FeedController>().addPost(newPost);
      isPosting.value = false;
      Get.back();
      Get.snackbar('Success', 'Post shared with travelers!');
    });
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
