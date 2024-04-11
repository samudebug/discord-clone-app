import 'package:discord_clone_app/pages/initial/initial_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialPage extends GetView<InitialPageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => PopScope(
          canPop: controller.currentPage.value == 0,
          onPopInvoked: (_) {
            controller.handleBack();
          },
          child: Scaffold(
            appBar: controller.currentPage.value > 0
                ? AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => controller.handleBack(),
                    ),
                  )
                : null,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                  controller: controller.pageViewController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    initialPage(context),
                    loginPage(context),
                    signupPage(context)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  loginPage(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Boas-vindas de volta!",
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Estamos muito animados de te ver novamente!",
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodySmall
                  ?.copyWith(color: context.theme.colorScheme.onBackground),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Informações da conta",
              textAlign: TextAlign.start,
              style: context.theme.textTheme.bodySmall
                  ?.copyWith(color: context.theme.colorScheme.onBackground),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
              controller: controller.emailController,
              validator: controller.validateEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Senha"),
              controller: controller.passwordController,
              validator: controller.validatePassword,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              child: Text(
                "Esqueceu sua senha?",
                textAlign: TextAlign.start,
                style: context.theme.textTheme.bodySmall
                    ?.copyWith(color: context.theme.colorScheme.primary),
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.primary,
                  foregroundColor: context.theme.colorScheme.onPrimary),
              onPressed: () => controller.submit(),
            ),
          ),
        ],
      ),
    );
  }

  signupPage(BuildContext context) {
    return Form(
      key: controller.signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Boas-vindas!",
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Estamos muito animados de te ver aqui!",
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodySmall
                  ?.copyWith(color: context.theme.colorScheme.onBackground),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Informações da conta",
              textAlign: TextAlign.start,
              style: context.theme.textTheme.bodySmall
                  ?.copyWith(color: context.theme.colorScheme.onBackground),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
              controller: controller.emailController,
              validator: controller.validateEmail,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Senha"),
              controller: controller.passwordController,
              validator: controller.validatePassword,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Confirmar Senha"),
              controller: controller.confirmPasswordController,
              validator: controller.validatePassword,
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              child: Text("Cadastrar-se"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.primary,
                  foregroundColor: context.theme.colorScheme.onPrimary),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Column initialPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Image(
            image: AssetImage('assets/banner.png'),
            width: 250,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Bem-vindo (ou vinda) ao Discord",
            textAlign: TextAlign.center,
            style: context.theme.textTheme.displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Junte-se a mais de 100 milhões de pessoas que usam o Discord para conversar com seus amigos e comunidades.",
            textAlign: TextAlign.center,
            style: context.theme.textTheme.bodySmall
                ?.copyWith(color: context.theme.colorScheme.onBackground),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: () => controller.goToLogin(),
            style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.colorScheme.primary,
                foregroundColor: context.theme.colorScheme.onPrimary),
            child: Text("Login"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: () => controller.goToSignup(),
            style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.colorScheme.secondary,
                foregroundColor: context.theme.colorScheme.onSecondary),
            child: Text("Cadastre-se"),
          ),
        )
      ],
    );
  }
}
