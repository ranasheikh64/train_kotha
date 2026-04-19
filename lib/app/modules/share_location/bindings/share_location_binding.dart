import 'package:get/get.dart';
import 'package:train_kotai/app/modules/share_location/controllers/share_location_controller.dart';

class ShareLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareLocationController>(
      () => ShareLocationController(),
    );
  }
}
