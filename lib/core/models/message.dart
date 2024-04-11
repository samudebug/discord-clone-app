import 'package:discord_clone_app/core/models/profile.dart';

class Message {
  String id;
  String content;
  String attachmentUrl;
  DateTime createdAt;
  Profile? sender;

  Message(
      {required this.id, required this.content, required this.attachmentUrl, this.sender, required this.createdAt});

  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        attachmentUrl = json['attachmentUrl'],
        createdAt = DateTime.parse(json['createdAt']),
        sender = json['sender'] != null ? Profile.fromJson(json['sender']) : null;
}
