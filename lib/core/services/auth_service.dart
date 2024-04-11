import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final repo = Get.find<AuthRepository>();

  login({required String email, required String password}) {
    return repo.login(email: email, password: password);
  }

  signUp({required String email, required String password}) {
    return repo.signUp(email: email, password: password);
  }

  signOut() {
    return repo.signOut();
  }

  get currentUser => repo.currentUser();

  checkUserLoggedIn() {
    repo.userChanges.listen((event) {
      if (event == null) {
        Get.offAllNamed('/');
      }
    });
  }
}
