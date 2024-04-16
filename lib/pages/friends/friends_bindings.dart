import 'package:discord_clone_app/pages/friends/friends_controller.dart';
import 'package:get/get.dart';

class FriendsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendsPageController());
  }
}