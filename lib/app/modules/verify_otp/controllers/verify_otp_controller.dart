import 'dart:async';
import 'package:get/get.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class VerifyOtpController extends GetxController {
  final otpCode = ''.obs;
  final timerText = '01:30 S'.obs;
  final isLoading = false.obs;
  Timer? _timer;
  int _secondsRemaining = 90;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 90;
    _updateTimerText();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        _updateTimerText();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _updateTimerText() {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    timerText.value = '$minutes:$seconds S';
  }

  void submitCode() async {
    if (otpCode.value.length < 4) {
      Get.snackbar(
        'Error',
        'Please enter the 4-digit code',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    // Navigate to Reset Password
    Get.toNamed(Routes.RESET_PASSWORD);
  }

  void resendCode() {
    _startTimer();
    Get.snackbar(
      'Resent',
      'A new verification code has been sent to your email.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
