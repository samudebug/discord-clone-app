import 'package:discord_clone_app/core/models/attachment.dart';
import 'package:flutter/widgets.dart';

class ImageAttachmentItem extends StatelessWidget {
  const ImageAttachmentItem({super.key, required this.attachment});
  final ImageAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(attachment.url),
      width: 400,
    );
  }
}
