import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfileInfoController extends GetxController {
  final profileRepo = Get.find<ProfileRepository>();
  final profile = Rx<Profile?>(null);
  
  

  Future<void> init() async {
    profile.value = await profileRepo.getProfile();
  }

  void openProfile() async {
    await Get.toNamed('/profile');
    init();
  }

}