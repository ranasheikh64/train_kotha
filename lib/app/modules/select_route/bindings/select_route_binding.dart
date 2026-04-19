import 'package:get/get.dart';
import 'package:train_kotai/app/modules/select_route/controllers/select_route_controller.dart';

class SelectRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectRouteController>(
      () => SelectRouteController(),
    );
  }
}
