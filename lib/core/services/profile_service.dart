import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfileService extends GetxService {
  final repo = Get.find<ProfileRepository>();
  Future<Profile?> getProfile() {
    return repo.getProfile();
  }

  Future<Profile> updateProfile(
      {required String uid,
      required String username,
      required String displayName,
      String photoUrl = '',
      bool completedOnboarding = false}) {
    return repo.updateProfile(
        uid: uid,
        username: username,
        displayName: displayName,
        photoUrl: photoUrl,
        completedOnboarding: completedOnboarding);
  }
}
