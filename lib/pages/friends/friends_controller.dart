import 'dart:developer';

import 'package:discord_clone_app/core/models/connection.dart';
import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:discord_clone_app/core/repositories/connections/connections_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:discord_clone_app/core/services/auth_service.dart';
import 'package:get/get.dart';

class FriendsPageController extends GetxController {
  final friends = <Connection>[].obs;
  final connectionRepo = Get.find<ConnectionsRepository>();
  final chatRepo = Get.find<ChatRepository>();
  final authService = Get.find<AuthService>();
  final profileRepo = Get.find<ProfileRepository>();
  final profile = Rx<Profile?>(null);

  FriendsPageController() {
    init();
  }

  void init() async {
    try {
      friends.value = await connectionRepo.getConnections(
          status: ConnectionStatus.APPROVED);
      profile.value = await profileRepo.getProfile();
      log("Profile $profile");
    } catch (e) {
      log(e.toString(), error: e);
      Get.snackbar("Error", "Ocorreu um erro");
    }
  }

  void goToChat(String chatWith) async {
    final chat = await chatRepo.getChatWith(chatWith: chatWith);
    if (chat == null) {
      final profile = await profileRepo.getProfile();
      if (profile == null) {
        throw ("Profile does not exist!");
      }
      final createdChat =
          await chatRepo.createChat(myProfile: profile.id, chatWith: chatWith);
      Get.offNamedUntil('/chats/${createdChat.id}',
          (route) => route.settings.name?.contains("chats") ?? false);
      return;
    }

    Get.offNamedUntil('/chats/${chat.id}',
        (route) => route.settings.name?.contains("chats") ?? false);
  }

  void goToAddFriend() async {
    await Get.toNamed('/profile/addFriend');
    friends.clear();
    init();
  }

  void onFriendAccept({required String connectionId}) async {
    await connectionRepo.acceptConnection(id: connectionId);
    final connIdx = friends.indexWhere((element) => element.id == connectionId);
    if (connIdx > -1) {
      friends[connIdx].status = ConnectionStatus.APPROVED;
    }
    friends.refresh();
  }

  void onFriendDecline({required String connectionId}) async {
    await connectionRepo.declineConnection(id: connectionId);

    final connIdx = friends.indexWhere((element) => element.id == connectionId);
    if (connIdx > -1) {
      friends.removeAt(connIdx);
    }
    friends.refresh();
  }
}
