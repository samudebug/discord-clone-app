import 'dart:developer';

import 'package:discord_clone_app/core/models/connection.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:discord_clone_app/core/repositories/connections/connections_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:get/get.dart';

class FriendsPageController extends GetxController {
  final friends = <Connection>[].obs;
  final connectionRepo = Get.find<ConnectionsRepository>();
  final chatRepo = Get.find<ChatRepository>();
  final profileRepo = Get.find<ProfileRepository>();

  FriendsPageController() {
    init();
  }

  void init() async {
    try {
      friends.value = await connectionRepo.getConnections(
          status: ConnectionStatus.APPROVED);
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
}
