import 'dart:io';

import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:discord_clone_app/core/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPageController extends GetxController {
  final profile = Rx<Profile?>(null);
  final profileRepo = Get.find<ProfileRepository>();
  final storageRepo = Get.find<StorageRepository>();
  final imageUrl = ''.obs;
  final displayNameController = TextEditingController();
  final displayName = ''.obs;
  final hasChanged = false.obs;
  final formKey = GlobalKey<FormState>();

  ProfileEditPageController() {
    init();
  }

  void init() async {
    profile.value = await profileRepo.getProfile();
    imageUrl.value = profile.value?.photoUrl ?? "";
    displayName.value = profile.value?.displayName ?? "";
    displayNameController.text = profile.value?.displayName ?? "";
  }

  void submit() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await profileRepo.updateProfile(
            uid: profile.value!.uid,
            username: profile.value!.username,
            displayName: displayNameController.text,
            photoUrl: imageUrl.value);
        Get.back();
      } catch (e) {
        Get.snackbar("Error", "Ocorreu um erro");
      }
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      imageUrl.value = await storageRepo.uploadFile(file);
      hasChanged.value = true;
    }
  }

  void onDisplayNameChanged(String displayName) {
    this.displayName.value = displayName;
    hasChanged.value = displayName != (profile.value?.displayName ?? "") ||
        imageUrl.value != (profile.value?.photoUrl ?? "");
  }

  String? validateDisplayName(String? displayName) {
    if ((displayName?.length ?? 0) == 0) {
      return 'Nome de Exibição não pode ser vazio';
    }
    return null;
  }
}
