import 'dart:developer';

import 'package:discord_clone_app/pages/chat/chat_controller.dart';
import 'package:discord_clone_app/widgets/chat_input.dart';
import 'package:discord_clone_app/widgets/message_item.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  final controller = Get.find<ChatPageController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                UserAvatar(
                  imageUrl: controller.chat.value?.members?[0].photoUrl ?? "",
                  userName:
                      controller.chat.value?.members?[0].displayName ?? "",
                  radius: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                      controller.chat.value?.members?[0].displayName ?? ""),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  final item = controller.messages[index];
                  return InkWell(
                    onLongPress: item.sender?.id == controller.profile.value?.id
                        ? () => controller.openMenu(messageId: item.id)
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: MessageItem(message: item),
                    ),
                  );
                },
                itemCount: controller.messages.length,
              )),
              ChatInput(
                onSend: (message) => controller.sendMessage(message),
                chatTitle: controller.chat.value?.members?[0].displayName ?? "",
              )
            ],
          ),
        ));
  }
}
