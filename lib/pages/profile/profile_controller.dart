import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  final profile = Rx<Profile?>(null);
  final profileRepo = Get.find<ProfileRepository>();

  ProfilePageController() {
    init();
  }
  void init() async {
    profile.value = await profileRepo.getProfile();
  }

  void openEdit() async {
    await Get.toNamed('/profile/edit');
    init();
  }
}
