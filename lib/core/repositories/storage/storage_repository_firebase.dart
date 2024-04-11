import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:discord_clone_app/core/repositories/storage/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepositoryFirebase implements StorageRepository {
  final instance = FirebaseStorage.instance;

  @override
  Future<String> uploadFile(File file) async {
    final storageRef = instance.ref();
    final fileRef = storageRef.child('avatars/${basename(file.path)}');
    try {
      await fileRef.putFile(file);
      return await fileRef.getDownloadURL();
    } catch (e) {
      log(e.toString(), error: e, name: "StorageRepository");
      Get.snackbar('Erro', 'Ocorreu um erro');
    }
    return '';
  }
}
