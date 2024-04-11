import 'dart:developer';

import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:get/get.dart';

class ChatPageController extends GetxController {
  final chatRepo = Get.find<ChatRepository>();
  final messages = <Message>[].obs;
  final chat = Rx<Chat?>(null);
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;

  int currentPage = 0;

  ChatPageController() {
    fetchChat();
    fetchMessages();
  }

  fetchChat() async {
    final chatId = Get.parameters['chatId'];
    if (chatId == null) return;
    log("Chat ID is not null $chatId", name: "ChatPageController");
    chat.value = await chatRepo.getChat(chatId: chatId);
    log("Chat Set ${chat.value?.id}");
  }

  fetchMessages() async {
    try {
      if (canFetchMore.value) {
        isLoadingMore.value = true;
        currentPage++;
        final chatId = Get.parameters['chatId'];
        if (chatId == null) throw ("Chat ID not set!");
        final results =
            await chatRepo.getMessages(chatId: chatId, page: currentPage);
        final totalPages = (results.total / 30).ceil();
        canFetchMore.value = currentPage < totalPages;
        messages.addAll(results.results);
      }
    } catch (e) {
      Get.snackbar("Erro", "Ocorreu um erro");
      log(e.toString(), error: e);
    } finally {
      loading.value = false;
      isLoadingMore.value = false;
    }
  }
}
