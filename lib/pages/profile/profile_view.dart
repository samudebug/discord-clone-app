import 'package:discord_clone_app/pages/profile/profile_controller.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfilePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(() => UserAvatar(
                    imageUrl: controller.profile.value?.photoUrl ?? "",
                    userName: controller.profile.value?.displayName ?? "")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: context.theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8)),
                child: Obx(() => Wrap(
                      direction: Axis.vertical,
                      spacing: 8,
                      children: [
                        Text(
                          controller.profile.value?.displayName ?? "",
                          style: context.theme.textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.profile.value?.username ?? "",
                          style: context.theme.textTheme.bodyLarge,
                        ),
                        ElevatedButton.icon(
                          onPressed: () => controller.openEdit(),
                          icon: Icon(Icons.edit),
                          label: Text("Editar Perfil"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  context.theme.colorScheme.primary,
                              foregroundColor:
                                  context.theme.colorScheme.onPrimary),
                        )
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () => Get.toNamed('/profile/friends'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                      color: context.theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Seus amigos"),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () => controller.signOut(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                      color: context.theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Sair"), Icon(Icons.keyboard_arrow_right)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
