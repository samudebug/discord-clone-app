import 'package:discord_clone_app/core/models/attachment.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FileAttachmentItem extends StatelessWidget {
  const FileAttachmentItem({super.key, required this.attachment});
  final FileAttachment attachment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: context.theme.colorScheme.secondaryContainer),
      child: Text(attachment.filename, overflow: TextOverflow.ellipsis,)
    );
  }
}