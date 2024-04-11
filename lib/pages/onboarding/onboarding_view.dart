import 'package:discord_clone_app/pages/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends GetView<OnboardingPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
              appBar: controller.currentPage.value > 0
                  ? AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => controller.handleBack(),
                      ),
                    )
                  : null,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                  controller: controller.pageViewController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    usernamePrompt(context),
                    displayNameAndPicture(context)
                  ],
                ),
              ),
            )));
  }

  usernamePrompt(BuildContext context) {
    return Form(
        key: controller.usernameFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Vamos configurar seu perfil!",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Primeiro coloque um username. Com ele, seus amigos o acharão no Discord.",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(hintText: "Username"),
                controller: controller.usernameController,
                validator: controller.validateUsername,
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.submitUsername(),
              child: Text("Continuar"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.primary,
                  foregroundColor: context.theme.colorScheme.onPrimary),
            )
          ],
        ));
  }

  displayNameAndPicture(BuildContext context) {
    return Form(
        key: controller.displayNameFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Vamos configurar seu perfil!",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Agora, defina seu Nome de Exibição e uma Foto de Perfil",
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: CircleAvatar(
                    radius: 40,
                    foregroundImage: controller.imageUrl.isNotEmpty
                        ? NetworkImage(controller.imageUrl.value)
                        : null,
                    backgroundColor: Get.theme.colorScheme.primary,
                    child: controller.imageUrl.isEmpty
                        ? Text(
                            controller.displayNameController.text.isEmpty
                                ? ""
                                : controller.displayNameController.text[0]
                                    .toUpperCase(),
                            style: context.theme.textTheme.titleLarge?.copyWith(
                                color: context.theme.colorScheme.onPrimary),
                          )
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      hintText: "Nome de Exibição",
                      labelText: "Nome de Exibição"),
                  controller: controller.displayNameController,
                  validator: controller.validateDisplayName,
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.submitDisplayNameAndAvatar(),
                child: Text("Finalizar"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.colorScheme.primary,
                    foregroundColor: context.theme.colorScheme.onPrimary),
              )
            ],
          ),
        ));
  }
}
