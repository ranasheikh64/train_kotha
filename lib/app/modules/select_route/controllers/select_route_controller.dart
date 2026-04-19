import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class TrainRoute {
  final String from;
  final String to;

  TrainRoute({required this.from, required this.to});
}

class SelectRouteController extends GetxController {
  final searchController = TextEditingController();
  final allRoutes = <TrainRoute>[].obs;
  final filteredRoutes = <TrainRoute>[].obs;
  final selectedRouteIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    _generateDummyRoutes();
    filteredRoutes.assignAll(allRoutes);
    searchController.addListener(_onSearchChanged);
  }

  void _generateDummyRoutes() {
    final cities = [
      // Dhaka Zone
      "Dhaka", "Kamalapur", "Airport", "Biman Bandar", "Tejgaon", "Tongi",
      "Joydebpur", "Gazipur", "Narsingdi", "Bhairab Bazar", "Ashuganj",
      "Brahmanbaria", "Akhaura", "Kasba", "Harashpur", "Nangalkot",
      "Laksam", "Cumilla", "Gunabati", "Feni", "Chattogram",

      // Chattogram Hill & Cox Line
      "Chattogram Cantonment", "Patiya", "Dohazari", "Satkania",
      "Chakaria", "Ramu", "Cox's Bazar",

      // Sylhet Zone
      "Sylhet", "Maijgaon", "Kulaura", "Srimangal", "Bhanugach",
      "Shamshernagar", "Baramchal", "Patharkandi", "Shahbazpur",

      // Mymensingh Line
      "Mymensingh", "Gafargaon", "Sreepur", "Bhaluka Road",
      "Phulpur", "Jamalpur Town", "Sarishabari", "Islampur",
      "Dewanganj", "Bahadurabad Ghat",

      // Jamuna Bridge Line
      "Bangabandhu Bridge East", "Bangabandhu Bridge West",
      "Sirajganj", "Ullapara", "Salanga", "Tarash",

      // Rajshahi Zone
      "Ishwardi", "Pakshi", "Natore", "Rajshahi", "Abdulpur",
      "Chapainawabganj", "Rohanpur", "Amnura",

      // Khulna Zone
      "Khulna", "Noapara", "Jessore", "Benapole", "Bagherhat",
      "Mongla", "Satkhira",

      // Kushtia Line
      "Kushtia", "Meherpur", "Chuadanga", "Alamdanga", "Darshana",

      // Rangpur Zone
      "Parbatipur", "Dinajpur", "Fulbari", "Birampur", "Phulbari",
      "Saidpur", "Nilphamari", "Domar", "Chilahati",
      "Lalmonirhat", "Burimari", "Kaunia", "Rangpur",

      // Panchagarh Line
      "Pirganj", "Thakurgaon", "Panchagarh",

      // Barisal / South (limited rail)
      "Barisal", "Jhalokati", "Patuakhali", "Bhola",

      // Additional smaller stations (sample expansion)
      "Talora", "Santahar", "Ahsanganj", "Madhnagar", "Atrai",
      "Raninagar", "Nazipur", "Kakonhat", "Boral Bridge",
      "Shahjadpur", "Belkuchi", "Enayetpur", "Bera",
      "Chatmohar", "Faridpur", "Rajbari", "Goalundo Ghat",
      "Kalukhali", "Bhatiapara", "Gopalganj", "Madaripur",
      "Shariatpur",
    ];

    final routes = <TrainRoute>[];
    for (int i = 0; i < 50; i++) {
      String from = cities[i % cities.length];
      String to = cities[(i + 3) % cities.length];
      if (from == to) to = cities[(i + 1) % cities.length];
      routes.add(TrainRoute(from: from, to: to));
    }
    allRoutes.assignAll(routes);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredRoutes.assignAll(allRoutes);
    } else {
      filteredRoutes.assignAll(
        allRoutes.where((route) {
          return route.from.toLowerCase().contains(query) ||
              route.to.toLowerCase().contains(query);
        }).toList(),
      );
    }
  }

  void selectRoute(int index) {
    selectedRouteIndex.value = index;
  }

  void goToHome() {
    if (selectedRouteIndex.value == -1) {
      Get.snackbar(
        'Required',
        'Please select a route first',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.offAllNamed(Routes.DASHBOARD);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
