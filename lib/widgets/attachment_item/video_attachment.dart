import 'package:discord_clone_app/core/models/attachment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoAttachmentItem extends StatefulWidget {
  const VideoAttachmentItem({super.key, required this.attachment});
  final VideoAttachment attachment;
  @override
  State<VideoAttachmentItem> createState() => _VideoAttachmentItemState();
}

class _VideoAttachmentItemState extends State<VideoAttachmentItem> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.attachment.url));

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            }
            return Container();
          }),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(999)),
        child: IconButton(
            icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () => setState(() {
               _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
            })),
      )
    ]);
  }
}
