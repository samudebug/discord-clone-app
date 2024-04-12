import 'package:discord_clone_app/pages/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePageController());
  }
}
