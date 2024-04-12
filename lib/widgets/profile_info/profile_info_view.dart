import 'package:discord_clone_app/widgets/profile_info/profile_info_controller.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfo extends GetView<ProfileInfoController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openProfile(),
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(8),
        child: Obx(() => controller.profile.value != null
            ? Row(
              mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: UserAvatar(
                      imageUrl: controller.profile.value!.photoUrl ?? "",
                      userName: controller.profile.value!.displayName,
                      radius: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(controller.profile.value!.displayName),
                  ),
                  const Icon(Icons.keyboard_arrow_right)
                ],
              )
            : Container()),
      ),
    );
  }
}
