import 'package:discord_clone_app/core/services/auth_service.dart';
import 'package:discord_clone_app/widgets/recover_password/recover_password_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialPageController extends GetxController {
  final pageViewController = PageController();
  final authService = Get.find<AuthService>();
  final currentPage = 0.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  submit() async {
    if (currentPage.value == 0) return;
    if (currentPage.value == 1) {
      if (loginFormKey.currentState?.validate() ?? false) {
        await authService.login(
            email: emailController.text, password: passwordController.text);
      }
    }

    if (currentPage.value == 2) {
      if (signupFormKey.currentState?.validate() ?? false) {
        await authService.signUp(
            email: emailController.text, password: passwordController.text);
      }
    }
    Get.offAllNamed('/chats');
  }

  goToLogin() {
    emailController.clear();
    passwordController.clear();
    pageViewController.jumpToPage(1);
    currentPage.value = 1;
  }

  goToSignup() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    pageViewController.jumpToPage(2);
    currentPage.value = 2;
  }

  openRecoverPassword() {
    Get.dialog(Dialog(
      child: RecoverPasswordDialog(),
    ));
  }

  handleBack() {
    if (currentPage.value == 1 || currentPage.value == 2) {
      pageViewController.jumpToPage(0);
      currentPage.value = 0;
      return;
    }
    Get.back();
  }

  String? validateEmail(String? email) {
    if (email?.isEmpty ?? true) {
      return 'Email não pode ser vazio';
    }
    if (!(email?.isEmail ?? false)) {
      return 'É ncessário um email válido';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Senha não pode ser vazio';
    }

    if ((password?.length ?? 0) < 6) {
      return 'Senha não pode ter menos de 6 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(String? password) {
    if (password?.isEmpty ?? true) {
      return 'Senha não pode ser vazio';
    }

    if ((password?.length ?? 0) < 6) {
      return 'Senha não pode ter menos de 6 caracteres';
    }

    if ((password ?? "") != passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
