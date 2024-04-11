import 'dart:async';
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
  late final StreamSubscription subscription;

  int currentPage = 0;
  ChatPageController() {
    messages.clear();
    chat.value = null;
    fetchChat();
    fetchMessages();
    connectToChat();
  }
  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onClose() {
    log("On close called", name: "ChatPageController");
    chatRepo.disconnectFromChat();
    subscription.cancel();
    super.onClose();
  }

  fetchChat() async {
    final chatId = Get.parameters['chatId'];
    if (chatId == null) return;
    log("Chat ID is not null $chatId", name: "ChatPageController");
    chat.value = await chatRepo.getChat(chatId: chatId);
    log("Chat Set ${chat.value?.id}");
  }

  connectToChat() async {
    final chatId = Get.parameters['chatId'];

    if (chatId == null) return;

    await chatRepo.connectToChat(chatId: chatId);
    log("Chat connect requested", name: "ChatPageController");
    subscription = chatRepo.messagesStream.listen((event) {
      messages.insert(0, event);
    });
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

  sendMessage(String message) async {
    try {
      final chatId = Get.parameters['chatId'];
      if (chatId == null) throw ("Chat ID not set!");
      await chatRepo.sendMessage(chatId: chatId!, content: message);
    } catch (e) {
      Get.snackbar("Erro", "Ocorreu um erro");
      log(e.toString(), error: e);
    }
  }
}
