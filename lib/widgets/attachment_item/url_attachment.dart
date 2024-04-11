import 'package:discord_clone_app/core/models/attachment.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UrlAttachmentItem extends StatelessWidget {
  const UrlAttachmentItem({super.key, required this.attachment});
  final URLAttachment attachment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(attachment.title, style: context.theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
          Text(attachment.subtitle, style: context.theme.textTheme.titleSmall),
          Text("View more", style: context.theme.textTheme.titleSmall?.copyWith(color: context.theme.colorScheme.primary),)
        ],
      ),
    );
  }
}