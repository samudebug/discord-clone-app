import 'dart:developer';

import 'package:discord_clone_app/core/environment.dart';
import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:get/get.dart';

class ProfileRepositoryImpl extends GetConnect implements ProfileRepository {
  final authRepo = Get.find<AuthRepository>();
  @override
  void onInit() {
    httpClient.baseUrl = Environment.apiUrl;

    httpClient.addRequestModifier<dynamic>((request) async {
      log('url ${request.url}');
      final token = await authRepo.getToken();
      if (token != null) {
        request.headers['Authorization'] = token;
      }
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }

  @override
  Future<Profile?> getProfile() async {
    final response = await get('/profile/me');
    if (response.statusCode != 200 && response.statusCode != 404) {
      log("Response code ${response.statusCode}", name: "ProfileRepository");
      log("Response body ${response.body}", name: "ProfileRepository");
      throw ("An error has ocurred");
    }
    if (response.statusCode == 404) {
      return null;
    }
    final profile = Profile.fromJson(response.body);
    return profile;
  }

  @override
  Future<Profile> updateProfile(
      {required String uid,
      required String username,
      required String displayName,
      String photoUrl = '',
      bool completedOnboarding = false}) async {
    final body = <String, dynamic>{
      'uid': uid,
      'username': username,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'completedOnboarding': completedOnboarding
    };

    final response = await patch('/profile/me', body);
    if (response.statusCode != 200) {
      log("Response code ${response.statusCode}", name: "ProfileRepository");
      log("Response body ${response.body}", name: "ProfileRepository");
      throw ("An error has ocurred");
    }
    final Profile profile = Profile.fromJson(response.body);
    return profile;
  }

  @override
  Future<bool> checkUsername({required String username}) async {
    final response =
        await get('/profile/checkUsername', query: {'username': username});
    if (response.statusCode != 200) {
      log("Response code ${response.statusCode}", name: "ProfileRepository");
      log("Response body ${response.body}", name: "ProfileRepository");
      throw ("An error has ocurred");
    }
    return response.body['available'];
  }
}
