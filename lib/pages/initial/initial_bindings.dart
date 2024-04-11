import 'package:discord_clone_app/pages/initial/initial_controller.dart';
import 'package:get/get.dart';

class InitialPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialPageController());
  }
}
