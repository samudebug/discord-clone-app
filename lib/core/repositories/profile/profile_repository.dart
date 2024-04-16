import 'package:discord_clone_app/core/models/paginated_result.dart';
import 'package:discord_clone_app/core/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> updateProfile(
      {required String uid,
      required String username,
      required String displayName,
      String photoUrl = '',
      bool completedOnboarding = false});
  Future<Profile?> getProfile();

  Future<bool> checkUsername({required String username});
  Future<PaginatedResult<Profile>> searchProfiles({required String query});
}
