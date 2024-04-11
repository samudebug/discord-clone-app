import 'dart:io';

import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:discord_clone_app/core/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingPageController extends GetxController {
  final pageViewController = PageController();
  final profileRepo = Get.find<ProfileRepository>();
  final storageRepo = Get.find<StorageRepository>();
  final authRepo = Get.find<AuthRepository>();
  final currentPage = 0.obs;
  final usernameController = TextEditingController();
  final displayNameController = TextEditingController();
  final usernameFormKey = GlobalKey<FormState>();
  final displayNameFormKey = GlobalKey<FormState>();
  final imageUrl = ''.obs;

  handleBack() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageViewController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      return;
    }
    Get.back();
  }

  goToNextPage() {
    displayNameController.text = usernameController.text;
    currentPage.value++;
    pageViewController.animateToPage(
      currentPage.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  goToChats() {
    Get.toNamed('/chats');
  }

  submitUsername() async {
    if (usernameFormKey.currentState?.validate() ?? false) {
      try {
        final isUsernameAvailable = await profileRepo.checkUsername(
            username: usernameController.text.trim());
        if (!isUsernameAvailable) {
          Get.snackbar("Error", "This username is not available");
          return;
        }
      } catch (e) {
        Get.snackbar("Error", "This username is not available");
        return;
      }
      goToNextPage();
    }
  }

  submitDisplayNameAndAvatar() async {
    if (displayNameFormKey.currentState?.validate() ?? false) {
      try {
        final user = authRepo.currentUser();
        if (user == null) throw ("An error has ocurred");
        await profileRepo.updateProfile(
            uid: user.uid,
            username: usernameController.text,
            displayName: displayNameController.text,
            photoUrl: imageUrl.value,
            completedOnboarding: true);
        Get.offAllNamed('/chats');
      } catch (e) {
        Get.snackbar("Error", "This username is not available");
      }
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      imageUrl.value = await storageRepo.uploadFile(file);
    }
  }

  String? validateUsername(String? username) {
    if (!RegExp(r'^(?!.*?\.{2,})[a-z0-9_\.]{2,32}$').hasMatch(username ?? "")) {
      return 'Este username é inválido';
    }
    return null;
  }

  String? validateDisplayName(String? displayName) {
    if ((displayName?.length ?? 0) == 0) {
      return 'Nome de Exibição não pode ser vazio';
    }
    return null;
  }
}
