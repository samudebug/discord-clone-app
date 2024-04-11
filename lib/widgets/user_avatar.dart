import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {super.key,
      required this.imageUrl,
      required this.userName,
      this.radius = 40});
  final String imageUrl;
  final String userName;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      foregroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
      backgroundColor: context.theme.colorScheme.primary,
      child: imageUrl.isEmpty
          ? Text(
              userName.isEmpty ? "" : userName[0].toUpperCase(),
              style: context.theme.textTheme.titleLarge
                  ?.copyWith(color: context.theme.colorScheme.onPrimary),
            )
          : null,
    );
  }
}
