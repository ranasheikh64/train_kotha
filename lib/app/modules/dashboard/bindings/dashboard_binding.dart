import 'package:get/get.dart';
import 'package:train_kotai/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:train_kotai/app/modules/home/bindings/home_binding.dart';
import 'package:train_kotai/app/modules/track_train/controllers/track_train_controller.dart';
import 'package:train_kotai/app/modules/train_ai/controllers/train_ai_controller.dart';
import 'package:train_kotai/app/modules/feed/controllers/feed_controller.dart';
import 'package:train_kotai/app/modules/profile/controllers/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<TrackTrainController>(() => TrackTrainController());
    Get.lazyPut<TrainAIController>(() => TrainAIController());
    Get.lazyPut<FeedController>(() => FeedController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    HomeBinding().dependencies();
  }
}
