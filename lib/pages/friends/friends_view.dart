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
                onPressed: () => Get.toNamed('/profile/addFriend'),
                child: const Text("Adicionar Amigos"))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => ListView.builder(
                  itemCount: controller.friends.length,
                  itemBuilder: (context, index) {
                    final item = controller.friends[index];
                    return FriendItem(
                      profile: item.profiles[0],
                      isFriend: item.status == ConnectionStatus.APPROVED,
                      onMessageTap: (chatWith) => controller.goToChat(chatWith),
                    );
                  }),
            )),
      ),
    );
  }
}
