import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/models/profile.dart';

class Chat {
  String id;
  List<Profile>? members;
  List<Message>? messages;
  Chat({required this.id, required this.members, required this.messages});

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        members = (json['members'] as List<dynamic>)
            .map<Profile>((e) => Profile.fromJson(e))
            .toList(),
        messages = json['messages'] != null
            ? (json['messages'] as List<dynamic>)
                .map<Message>((e) => Message.fromJson(e))
                .toList()
            : null;
}
