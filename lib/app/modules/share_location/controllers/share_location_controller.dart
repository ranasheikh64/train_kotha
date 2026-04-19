import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareLocationController extends GetxController {
  // Mock Data
  final allTrains = [
    'Mohanagar Express',
    'Suborno Express',
    'Parabat Express',
    'Upakul Express',
    'Jayantika Express',
    'Turna Express',
    'Egarosindhur Express',
    'Kalni Express',
    'Silkcity Express',
    'Padma Express',
  ].obs;

  final allStations = [
    'Kamalapur',
    'Dhaka Airport',
    'Tongi',
    'Gogorgaon',
    'Mymensingh',
    'Gafargaon',
    'Sreepur',
    'Joydebpur',
    'Kishoreganj',
    'Bhairab Bazar',
  ].obs;

  // Selected States
  final selectedTrain = 'Mohanagar Express'.obs;
  final currentStation = 'Tongi'.obs;
  final targetStation = ''.obs;

  // Controllers
  final currentStationController = TextEditingController(text: 'Tongi');
  final targetStationController = TextEditingController();

  // Expansion States
  final isCurrentExpanded = false.obs;
  final isTargetExpanded = false.obs;

  // Search Logic for Current Station
  final filteredCurrentStations = <String>[].obs;

  // Search Logic for Target Station
  final filteredTargetStations = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCurrentStations.assignAll(allStations);
    filteredTargetStations.assignAll(allStations);
    
    // Listen to current station search
    currentStationController.addListener(() {
      final query = currentStationController.text;
      if (query.isEmpty) {
        filteredCurrentStations.assignAll(allStations);
      } else {
        filteredCurrentStations.assignAll(
          allStations.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList(),
        );
      }
    });

    // Listen to target station search
    targetStationController.addListener(() {
      final query = targetStationController.text;
      if (query.isEmpty) {
        filteredTargetStations.assignAll(allStations);
      } else {
        filteredTargetStations.assignAll(
          allStations.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList(),
        );
      }
    });
  }

  void selectTrain(String? train) {
    if (train != null) {
      selectedTrain.value = train;
    }
  }

  void selectCurrentStation(String station) {
    currentStation.value = station;
    currentStationController.text = station;
    isCurrentExpanded.value = false;
  }

  void selectTargetStation(String station) {
    targetStation.value = station;
    targetStationController.text = station;
    isTargetExpanded.value = false;
  }

  void toggleCurrentExpansion() {
    isCurrentExpanded.toggle();
    if (isCurrentExpanded.value) isTargetExpanded.value = false;
  }

  void toggleTargetExpansion() {
    isTargetExpanded.toggle();
    if (isTargetExpanded.value) isCurrentExpanded.value = false;
  }

  void onContinue() {
    if (selectedTrain.value.isEmpty || currentStation.value.isEmpty || targetStation.value.isEmpty) {
      Get.snackbar(
        'Incomplete Selection', 
        'Please select Train, Current Station, and Target Station.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    Get.toNamed('/map-tracking');
  }

  @override
  void onClose() {
    currentStationController.dispose();
    targetStationController.dispose();
    super.onClose();
  }
}
