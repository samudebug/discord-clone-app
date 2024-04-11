import 'package:discord_clone_app/core/models/user.dart';

abstract class AuthRepository {
  login({required String email, required String password});
  signUp({required String email, required String password});
  signOut();
  Future<String?>? getToken();

  UserModel? currentUser();

  Stream<UserModel?> get userChanges;
}