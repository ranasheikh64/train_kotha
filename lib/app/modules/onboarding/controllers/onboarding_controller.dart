import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;
  final isLastPage = false.obs;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/splash_screen_image.png',
      title: 'Track Your Train',
      description: 'Track your train in real time with interactive map updates, so you always know its location and route.',
    ),
    OnboardingData(
      image: 'assets/onboarding-2.png',
      title: 'Real-time Updates',
      description: 'Get instant notifications about train schedules, delays, and platform changes.',
    ),
    OnboardingData(
      image: 'assets/onboarding_3.png',
      title: 'Easy Ticketing',
      description: 'Book your train tickets with just a few taps and avoid long queues at the station.',
    ),
    OnboardingData(
      image: 'assets/onboarding_4.png',
      title: 'Plan Your Journey',
      description: 'Our advanced route planner helps you find the quickest and most comfortable way to reach your destination.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
    isLastPage.value = index == onboardingPages.length - 1;
  }

  void nextPage() {
    if (isLastPage.value) {
      skip();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skip() {
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
