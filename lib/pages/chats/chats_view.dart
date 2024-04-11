import 'package:discord_clone_app/pages/chats/chats_controller.dart';
import 'package:discord_clone_app/widgets/profile_info/profile_info_view.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsPage extends GetView<ChatsPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Mensagens"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Obx(() => ListView.builder(
                  itemCount: controller.chats.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.goToChatPage(controller.chats[index].id),
                    child: ListTile(
                      title: Text(controller.chats[index].members?[0].displayName ?? ""),
                      subtitle: controller.chats[index].messages?.isNotEmpty ?? false
                          ? Text(
                              controller.chats[0].messages?[0].content ?? "",
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      leading: UserAvatar(
                        imageUrl:
                            controller.chats[index].members?[0].photoUrl ?? "",
                        userName: controller.chats[index].members?[0].displayName ?? "",
                        radius: 20,
                      ),
                    ),
                  ),
                )),
            Positioned(
              bottom: 0,
              child: ProfileInfo(),
            )
          ],
        ),
      ),
    ));
  }
}
