import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/widgets/attachment_item/attachment_item.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: UserAvatar(
            imageUrl: message.sender?.photoUrl ?? "",
            userName: message.sender?.displayName ?? "",
            radius: 20,
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      message.sender?.displayName ?? "",
                      style: context.theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      DateFormat("EEEE, HH:mm").format(message.createdAt),
                      style: context.theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              if(message.content.isNotEmpty && !message.content.isURL) Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Text(
                   message.content,
                  style: context.theme.textTheme.bodyMedium,
                ),
              ),
              if (message.attachment != null)
                Container(
                    child: AttachmentItem(
                  attachment: message.attachment!,
                ))
            ],
          ),
        ),
      ],
    );
  }
}
