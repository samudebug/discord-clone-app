import 'package:discord_clone_app/pages/add_friend/add_friend_controller.dart';
import 'package:get/get.dart';

class AddFriendPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AddFriendPageController());
  }
}