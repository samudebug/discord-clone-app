import 'package:discord_clone_app/pages/profile_edit/profile_edit_controller.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditPage extends GetView<ProfileEditPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
        centerTitle: true,
        actions: [
          Obx(() => TextButton(
              onPressed: !controller.hasChanged.value
                  ? null
                  : () => controller.submit(),
              child: Text("Salvar")))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(() => GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: UserAvatar(
                          imageUrl: controller.imageUrl.value,
                          userName:
                              controller.profile.value?.displayName ?? ""),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: context.theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8)),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            controller.displayName.value,
                            style: context.theme.textTheme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            controller.profile.value?.username ?? "",
                            style: context.theme.textTheme.bodyLarge,
                          ),
                        ),
                        Form(
                          key: controller.formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: controller.displayNameController,
                              onChanged: controller.onDisplayNameChanged,
                              validator: controller.validateDisplayName,
                              decoration: InputDecoration(
                                hintText: "Nome de exibição",
                                labelText: "Nome de exibição",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
