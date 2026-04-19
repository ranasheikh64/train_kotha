import 'package:get/get.dart';
import 'package:train_kotai/app/modules/map_tracking/controllers/map_tracking_controller.dart';

class MapTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapTrackingController>(
      () => MapTrackingController(),
    );
  }
}
