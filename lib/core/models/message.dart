import 'package:discord_clone_app/core/models/attachment.dart';
import 'package:discord_clone_app/core/models/profile.dart';

class Message {
  String id;
  String content;
  String attachmentUrl;
  DateTime createdAt;
  Profile? sender;
  Attachment? attachment;

  Message(
      {required this.id, required this.content, required this.attachmentUrl, this.sender, required this.createdAt, this.attachment});

  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        attachmentUrl = json['attachmentUrl'],
        createdAt = DateTime.parse(json['createdAt']),
        sender = json['sender'] != null ? Profile.fromJson(json['sender']) : null,
        attachment = json['attachment'] != null ? AttachmentFactory.getAttachmentFromJson(json['attachment']) : null;
}
