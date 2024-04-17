import 'package:discord_clone_app/core/models/connection.dart';

abstract class ConnectionsRepository {
  Future<List<Connection>> getConnections({ConnectionStatus? status});
  Future<Connection> createConnection({required String to});
  Future<Connection> acceptConnection({required String id});
  Future<void> declineConnection({required String id});
}