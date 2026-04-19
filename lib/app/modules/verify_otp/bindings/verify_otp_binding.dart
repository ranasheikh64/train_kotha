import 'package:get/get.dart';
import 'package:train_kotai/app/modules/verify_otp/controllers/verify_otp_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpController>(
      () => VerifyOtpController(),
    );
  }
}
