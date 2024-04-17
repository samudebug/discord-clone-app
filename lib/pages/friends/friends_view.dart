import 'dart:developer';

import 'package:discord_clone_app/core/models/connection.dart';
import 'package:discord_clone_app/pages/friends/friends_controller.dart';
import 'package:discord_clone_app/widgets/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsPage extends GetView<FriendsPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Amigos"),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () => controller.goToAddFriend(),
                child: const Text("Adicionar Amigos"))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => controller.friends.isEmpty
                  ? Center(
                      child: Text(
                          "Sem amigos aqui. Mas você pode adicionar mais clicando em 'mais amigos'"),
                    )
                  : ListView.builder(
                      itemCount: controller.friends.length,
                      itemBuilder: (context, index) {
                        final item = controller.friends[index];
                        log("My Profile ID ${controller.profile.value?.id}");
                        log("From Profile ID ${item.from}");

                        return FriendItem(
                          profile: controller.friends[index].profiles[0],
                          isFriend: controller.friends[index].status ==
                              ConnectionStatus.APPROVED,
                          onMessageTap: (chatWith) =>
                              controller.goToChat(chatWith),
                          wasRequestSentByMe:
                              (controller.profile.value?.id ?? "") == item.from,
                          onFriendAccept: () =>
                              controller.onFriendAccept(connectionId: item.id),
                          onFriendDecline: () =>
                              controller.onFriendDecline(connectionId: item.id),
                        );
                      }),
            )),
      ),
    );
  }
}
