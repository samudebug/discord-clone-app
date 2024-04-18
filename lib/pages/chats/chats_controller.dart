import 'dart:developer';

import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:discord_clone_app/core/services/auth_service.dart';
import 'package:discord_clone_app/widgets/profile_info/profile_info_controller.dart';
import 'package:get/get.dart';

class ChatsPageController extends GetxController {
  final profileRepo = Get.find<ProfileRepository>();
  final chatRepo = Get.find<ChatRepository>();
  final authService = Get.find<AuthService>();
  final chats = <Chat>[].obs;
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;

  int currentPage = 0;
  ChatsPageController() {
    init();
  }

  init() async {
    final Profile? profile = await profileRepo.getProfile();
    Get.find<ProfileInfoController>().init();
    if (profile == null || !profile.completedOnboarding) {
      log("Has not completed onboarding", name: "ChatsPageController");
      Get.offAllNamed('/onboarding');
      return;
    }
    await fetchChats();
  }

  fetchChats() async {
    try {
      if (canFetchMore.value && authService.currentUser != null) {
        isLoadingMore.value = true;
        currentPage++;
        final results = await chatRepo.getChats(page: currentPage);
        final totalPages = (results.total / 30).ceil();
        canFetchMore.value = currentPage < totalPages;
        chats.addAll(results.results);
      }
    } catch (e) {
      Get.snackbar("Erro", "Ocorreu um erro");
      log(e.toString(), error: e);
    } finally {
      loading.value = false;
      isLoadingMore.value = false;
    }
  }

  goToChatPage(String chatId) {
    Get.toNamed('/chats/$chatId');
  }
}
