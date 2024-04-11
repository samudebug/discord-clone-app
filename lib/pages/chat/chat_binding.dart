import 'package:discord_clone_app/pages/chat/chat_controller.dart';
import 'package:get/get.dart';

class ChatPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatPageController());
  }
}