import 'package:discord_clone_app/core/models/profile.dart';
import 'package:discord_clone_app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({super.key, required this.profile, required this.isFriend, required this.onMessageTap});
  final Profile profile;
  final bool isFriend;
  final void Function(String chatWith) onMessageTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: UserAvatar(
                    imageUrl: profile.photoUrl ?? "",
                    userName: profile.displayName,
                    radius: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    profile.displayName,
                    style: context.theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          if (isFriend)
            IconButton(
              onPressed: () {
                onMessageTap(profile.id);
              },
              icon: Icon(Icons.message),
              style: IconButton.styleFrom(
                  backgroundColor: context.theme.colorScheme.primary,
                  foregroundColor: context.theme.colorScheme.onPrimary),
            )
          else
            Text("Pendente")
        ],
      ),
    );
  }
}
