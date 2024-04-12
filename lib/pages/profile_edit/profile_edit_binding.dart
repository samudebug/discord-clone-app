import 'package:discord_clone_app/pages/profile_edit/profile_edit_controller.dart';
import 'package:get/get.dart';

class ProfileEditPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileEditPageController());
  }
}