import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatInput extends StatelessWidget {
  ChatInput(
      {super.key,
      required this.onSend,
      required this.chatTitle,
      required this.onPickAttachment,
      required this.attachmentUrl});
  final messageController = TextEditingController();
  final void Function(String message, String attachmentUrl) onSend;
  final String chatTitle;
  final void Function() onPickAttachment;
  final String attachmentUrl;

  bool get canSendMessage {
    if (attachmentUrl.isEmpty) {
      return messageController.text.isNotEmpty;
    }
    return attachmentUrl.isNotEmpty;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: context.theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(999)),
          child: Badge(
            isLabelVisible: attachmentUrl.isNotEmpty,
            label: Text("1"),
            child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: context.theme.colorScheme.onSecondary,
                ),
                onPressed: () {
                  onPickAttachment();
                }),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: messageController,
            decoration: InputDecoration(
                hintText: "Message $chatTitle",
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                )),
          ),
        )),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(999)),
          child: IconButton(
              icon: Icon(
                Icons.send,
                color: context.theme.colorScheme.onPrimary,
              ),
              onPressed: canSendMessage
                  ? () {
                      onSend(messageController.text, attachmentUrl);
                      messageController.clear();
                    }
                  : null),
        )
      ],
    );
  }
}
