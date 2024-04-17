import 'dart:developer';

import 'package:discord_clone_app/core/environment.dart';
import 'package:discord_clone_app/core/models/connection.dart';
import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:discord_clone_app/core/repositories/connections/connections_repository.dart';
import 'package:get/get.dart';

class ConnectionsRepositoryImpl extends GetConnect
    implements ConnectionsRepository {
  final authRepo = Get.find<AuthRepository>();
  @override
  void onInit() {
    httpClient.baseUrl = Environment.apiUrl;

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await authRepo.getToken();
      if (token != null) {
        request.headers['Authorization'] = token;
      }
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }

  @override
  Future<List<Connection>> getConnections({ConnectionStatus? status}) async {
    final query = <String, dynamic>{};
    if (status != null) {
      query['status'] = status.name;
    }
    final response = await get('/connections', query: query);

    if (response.statusCode != 200) {
      log("Response code ${response.statusCode}", name: "ConnectionRepository");
      log("Response body ${response.body}", name: "ConnectionRepository");
      throw ("An error has ocurred");
    }
    final List<Connection> connections = (response.body as List<dynamic>)
        .map((e) => Connection.fromJson(e))
        .toList();
    return connections;
  }

  @override
  Future<Connection> createConnection({required String to}) async {
    final body = <String, dynamic>{'to': to};
    final response = await post('/connections', body);

    if (response.statusCode == 401) {
      throw ("This user is blocked");
    }

    if (response.statusCode != 201 && response.statusCode != 401) {
      log("Response code ${response.statusCode}", name: "ConnectionRepository");
      log("Response body ${response.body}", name: "ConnectionRepository");
      throw ("An error has ocurred");
    }

    final connection = Connection.fromJson(response.body);
    return connection;
  }

  @override
  Future<Connection> acceptConnection({required String id}) async {
    final response = await patch(
        '/connections/$id', {'status': ConnectionStatus.APPROVED.name});
    if (response.statusCode == 404) {
      throw ("This connection does not exist");
    }

    if (response.statusCode != 200 && response.statusCode != 404) {
      log("Response code ${response.statusCode}", name: "ConnectionRepository");
      log("Response body ${response.body}", name: "ConnectionRepository");
      throw ("An error has ocurred");
    }

    final connection = Connection.fromJson(response.body);
    return connection;
  }

  @override
  Future<void> declineConnection({required String id}) async {
    final response = await delete('/connections/$id');
    if (response.statusCode == 404) {
      throw ("This connection does not exist");
    }

    if (response.statusCode != 200 && response.statusCode != 404) {
      log("Response code ${response.statusCode}", name: "ConnectionRepository");
      log("Response body ${response.body}", name: "ConnectionRepository");
      throw ("An error has ocurred");
    }
  }
}
