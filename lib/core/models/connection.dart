import 'package:discord_clone_app/core/models/profile.dart';

enum ConnectionStatus { PENDING, APPROVED, BLOCKED }

class Connection {
  String id;
  List<Profile> profiles;
  ConnectionStatus status;

  Connection({required this.id, required this.profiles, required this.status});

  Connection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        profiles = (json['profiles'] as List<dynamic>)
            .map((e) => Profile.fromJson(e))
            .toList(),
        status = ConnectionStatus.values.byName(json['status']);
}
