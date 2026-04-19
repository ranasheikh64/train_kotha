import 'package:get/get.dart';
import 'package:train_kotai/app/modules/add_post/controllers/add_post_controller.dart';

class AddPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPostController>(() => AddPostController());
  }
}
