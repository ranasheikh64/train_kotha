import 'package:get/get.dart';
import 'package:train_kotai/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:train_kotai/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final coins = 20.obs;
  final shareProgress = 0.5.obs; // 02/04 logic
  final shareCountText = '02/04'.obs;

  void addCoins() {
    coins.value += 5;
  }

  void onShareLocation() {
    Get.toNamed(Routes.SHARE_LOCATION);
  }

  void onTrack() {
    Get.find<DashboardController>().changeTab(1);
  }

  void onChatAI() {
    Get.find<DashboardController>().changeTab(2);
  }
}
