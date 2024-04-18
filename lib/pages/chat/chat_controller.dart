import 'dart:async';
import 'dart:developer';

import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:discord_clone_app/core/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPageController extends GetxController {
  final chatRepo = Get.find<ChatRepository>();
  final profileService = Get.find<ProfileService>();
  final messages = <Message>[].obs;
  final chat = Rx<Chat?>(null);
  final profile = Rx<Profile?>(null);
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;
  late final StreamSubscription subscription;

  int currentPage = 0;
  ChatPageController() {
    messages.clear();
    chat.value = null;
    profile.value = null;
    fetchProfile();
    fetchChat();
    fetchMessages();
    connectToChat();
  }

  @override
  void onClose() {
    log("On close called", name: "ChatPageController");
    chatRepo.disconnectFromChat();
    subscription.cancel();
    super.onClose();
  }

  Future<void> fetchProfile() async {
    profile.value = await profileService.getProfile();
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

  void openMenu({required String messageId}) {
    log("Opening menu", name: "ChatController");
    Get.bottomSheet(Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Get.theme.colorScheme.background),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => deleteMessage(messageId: messageId),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.delete,
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Apagar",
                      style: TextStyle(color: Get.theme.colorScheme.error),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> deleteMessage({required String messageId}) async {
    if (chat.value == null) return;

    await chatRepo.deleteMessage(chatId: chat.value!.id, messageId: messageId);
    messages.removeWhere((element) => element.id == messageId);
    messages.refresh();
    Get.back();
  }
}
