import 'package:discord_clone_app/core/models/connection.dart';

class Profile {
  String id;
  String uid;
  String username;
  String displayName;
  String? photoUrl;
  bool completedOnboarding;
  ConnectionStatus? status;

  Profile(
      {required this.id,
      required this.uid,
      required this.username,
      required this.displayName,
      this.photoUrl,
      this.completedOnboarding = false});
  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        uid = json['uid'],
        username = json['username'],
        displayName = json['displayName'],
        photoUrl = json['photoUrl'],
        completedOnboarding = json['completedOnboarding'],
        status = json['connections'] != null && (json['connections'] as List<dynamic>).isNotEmpty ? ConnectionStatus.values.byName(json['connections'][0]['status']) : null;
}
