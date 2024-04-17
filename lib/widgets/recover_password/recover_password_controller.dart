import 'package:discord_clone_app/core/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RecoverPasswordDialogController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final authService = Get.find<AuthService>();
  Future<void> submit() async {
    if (formKey.currentState?.validate() ?? false) {
      await authService.sendRecoverPasswordEmail(email: emailController.text);
      Get.back();
      Get.snackbar("Email enviado",
          "Foi enviado um email com um link para recuperar sua senha");
    }
  }

  String? validateEmail(String? email) {
    if (email?.isEmpty ?? false) {
      return "Este campo é necessário";
    }

    if (!(email?.isEmail ?? false)) {
      return "Insira um email válido";
    }
    return null;
  }
}
