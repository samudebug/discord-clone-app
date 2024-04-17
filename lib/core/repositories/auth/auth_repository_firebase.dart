import 'dart:developer';

import 'package:discord_clone_app/core/models/user.dart';
import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepositoryFirebase implements AuthRepository {
  final instance = FirebaseAuth.instance;

  @override
  login({required String email, required String password}) async {
    try {
      await instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Get.snackbar("Erro", "Este email é inválido");
      } else if (e.code == 'user-disabled') {
        Get.snackbar("Erro", "Você não está autorizado");
      } else if (e.code == 'user-not-found') {
        Get.snackbar("Erro", "Este usuário não existe");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Erro", "Sua senha está incorreta");
      } else {
        Get.snackbar("Erro", "An error has ocurred");
        log(e.toString());
      }
    }
  }

  @override
  signUp({required String email, required String password}) async {
    try {
      await instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "This email is already in use");
      } else if (e.code == 'invalid-email') {
        Get.snackbar("Error", "This email is invalid");
      } else if (e.code == 'weak-password') {
        Get.snackbar("Error", "Your password is too weak");
      } else {
        Get.snackbar("Error", "An error has ocurred");
      }
      rethrow;
    }
  }

  @override
  signOut() {
    return instance.signOut();
  }

  @override
  UserModel? currentUser() {
    final user = instance.currentUser;
    if (user != null) {
      return UserModel(
          uid: user.uid,
          displayName: user.displayName ?? "",
          photoUrl: user.photoURL);
    }
    return null;
  }

  @override
  Future<String?>? getToken() {
    return instance.currentUser?.getIdToken();
  }

  @override
  Stream<UserModel?> get userChanges =>
      instance.userChanges().map<UserModel?>((event) => event != null
          ? UserModel(
              uid: event.uid,
              displayName: event.displayName ?? "",
              photoUrl: event.photoURL)
          : null);

  @override
  Future<void> sendRecoverPasswordEmail({required String email}) async {
    instance.sendPasswordResetEmail(email: email);
  }
}
