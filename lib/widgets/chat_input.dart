import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatInput extends StatelessWidget {
  ChatInput({super.key, required this.onSend, required this.chatTitle});
  final messageController = TextEditingController();
  final void Function(String message) onSend;
  final String chatTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              onPressed: messageController.text.isNotEmpty
                  ? () {
                      onSend(messageController.text);
                      messageController.clear();
                    }
                  : null),
        )
      ],
    );
  }
}
