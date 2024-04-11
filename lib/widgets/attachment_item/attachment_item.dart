import 'package:discord_clone_app/core/models/attachment.dart';
import 'package:discord_clone_app/widgets/attachment_item/file_attachment.dart';
import 'package:discord_clone_app/widgets/attachment_item/image_attachment.dart';
import 'package:discord_clone_app/widgets/attachment_item/url_attachment.dart';
import 'package:discord_clone_app/widgets/attachment_item/video_attachment.dart';
import 'package:flutter/widgets.dart';

class AttachmentItem extends StatelessWidget {
  const AttachmentItem({super.key, required this.attachment});
  final Attachment attachment;
  @override
  Widget build(BuildContext context) {
    if (attachment is ImageAttachment) {
      return ImageAttachmentItem(attachment: (attachment as ImageAttachment));
    }
    if (attachment is VideoAttachment) {
      return VideoAttachmentItem(attachment: (attachment as VideoAttachment));
    }
    if (attachment is FileAttachment) {
      return FileAttachmentItem(attachment: (attachment as FileAttachment));
    }

    if (attachment is URLAttachment) {
      return UrlAttachmentItem(attachment: (attachment as URLAttachment));
    }
    return Container();
  }
}
