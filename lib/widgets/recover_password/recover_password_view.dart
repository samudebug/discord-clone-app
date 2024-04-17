import 'package:discord_clone_app/widgets/recover_password/recover_password_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RecoverPasswordDialog extends GetView<RecoverPasswordDialogController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Recover Password",
                style: context.theme.textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                controller: controller.emailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    controller.submit();
                  },
                  child: const Text("Enviar email para recuperação")),
            )
          ],
        ),
      ),
    );
  }
}
