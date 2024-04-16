
import 'package:discord_clone_app/core/models/connection.dart';
import 'package:discord_clone_app/pages/add_friend/add_friend_controller.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFriendPage extends GetView<AddFriendPageController> {
  Widget _getButtonForStatus(ConnectionStatus? status,
      {required String profileId}) {
    if (status == null) {
      return IconButton(
        icon: Icon(Icons.person_add),
        onPressed: () => controller.sendFriendConnection(to: profileId),
      );
    }

    switch (status) {
      case ConnectionStatus.APPROVED:
        return const Text("Amigos");
      case ConnectionStatus.PENDING:
        return const Text("Solicitação Enviada");
      case ConnectionStatus.BLOCKED:
        return Text(
          "Bloqueado",
          style: TextStyle(color: Get.theme.colorScheme.error),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Adicionar amigos"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Search"),
                  onChanged: controller.onQueryChanged,
                ),
                Expanded(
                    child: Obx(() => ListView.builder(
                        itemCount: controller.results.length,
                        itemBuilder: (context, index) {
                          final item = controller.results[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                                leading: UserAvatar(
                                  imageUrl: item.photoUrl ?? "",
                                  userName: item.displayName,
                                  radius: 20,
                                ),
                                title: Text(item.displayName),
                                trailing: _getButtonForStatus(item.status,
                                    profileId: item.id)),
                          );
                        })))
              ],
            ),
          )),
    );
  }
}
