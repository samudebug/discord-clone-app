import 'dart:developer';

import 'package:discord_clone_app/core/models/connection.dart';
import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/core/repositories/connections/connections_repository.dart';
import 'package:discord_clone_app/core/repositories/profile/profile_repository.dart';
import 'package:get/get.dart';

class AddFriendPageController extends GetxController {
  final results = <Profile>[].obs;
  final profileRepo = Get.find<ProfileRepository>();
  final connectionRepo = Get.find<ConnectionsRepository>();
  final query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchProfiles();
  }

  void onQueryChanged(String query) {
    this.query.value = query;
  }

  void searchProfiles() async {
    debounce(query, (callback) async {
      log("Search $callback", name: "AddFriendPageController");
      final searchResults = await profileRepo.searchProfiles(query: callback);
      results.clear();
      results.addAll(searchResults.results);
    }, time: Duration(seconds: 1));
  }

  void sendFriendConnection({required String to}) async {
    try {
      await connectionRepo.createConnection(to: to);
      results.firstWhereOrNull((p0) => p0.id == to)?.status =
          ConnectionStatus.PENDING;
      results.refresh();
      Get.snackbar(
          "Sucesso!", "Uma solicitação de amizade foi enviada ao usuário");
    } catch (e) {
      log(e.toString(), error: e, name: "AddFriendController");
      Get.snackbar("Erro", e.toString());
    }
  }
}
