import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:discord_clone_app/core/repositories/auth/auth_repository_firebase.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository_impl.dart';
import 'package:discord_clone_app/core/repositories/connections/connections_repository.dart';
import 'package:discord_clone_app/core/repositories/connections/connections_repository_impl.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository_impl.dart';
import 'package:discord_clone_app/core/repositories/storage/storage_repository.dart';
import 'package:discord_clone_app/core/repositories/storage/storage_repository_firebase.dart';
import 'package:discord_clone_app/core/services/auth_service.dart';
import 'package:discord_clone_app/widgets/profile_info/profile_info_controller.dart';
import 'package:get/get.dart';

initRepositories() async {
  await Get.putAsync<AuthRepository>(() async => AuthRepositoryFirebase());
  await Get.putAsync<ProfileRepository>(() async => ProfileRepositoryImpl());
  await Get.putAsync<StorageRepository>(
      () async => StorageRepositoryFirebase());
  await Get.putAsync<ChatRepository>(() async => ChatRepositoryImpl());
  await Get.putAsync<ConnectionsRepository>(
      () async => ConnectionsRepositoryImpl());
}

initServices() async {
  await Get.putAsync(() async => AuthService());
}

globalBindings() {
  Get.putAsync(() async => ProfileInfoController()..init());
}

init() async {
  await initRepositories();
  await initServices();
  globalBindings();
}
