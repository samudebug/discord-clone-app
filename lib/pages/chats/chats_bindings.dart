import 'package:discord_clone_app/pages/chats/chats_controller.dart';
import 'package:get/get.dart';

class ChatsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatsPageController());
  }
}
