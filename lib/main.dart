import 'package:discord_clone_app/core/core.dart';
import 'package:discord_clone_app/core/services/auth_service.dart';
import 'package:discord_clone_app/firebase_options.dart';
import 'package:discord_clone_app/pages/add_friend/add_friend_binding.dart';
import 'package:discord_clone_app/pages/add_friend/add_friend_view.dart';
import 'package:discord_clone_app/pages/chat/chat_binding.dart';
import 'package:discord_clone_app/pages/chat/chat_view.dart';
import 'package:discord_clone_app/pages/chats/chats_bindings.dart';
import 'package:discord_clone_app/pages/chats/chats_view.dart';
import 'package:discord_clone_app/pages/friends/friends_bindings.dart';
import 'package:discord_clone_app/pages/friends/friends_view.dart';
import 'package:discord_clone_app/pages/initial/initial_bindings.dart';
import 'package:discord_clone_app/pages/initial/initial_view.dart';
import 'package:discord_clone_app/pages/onboarding/onboarding_bindings.dart';
import 'package:discord_clone_app/pages/onboarding/onboarding_view.dart';
import 'package:discord_clone_app/pages/profile/profile_binding.dart';
import 'package:discord_clone_app/pages/profile/profile_view.dart';
import 'package:discord_clone_app/pages/profile_edit/profile_edit_binding.dart';
import 'package:discord_clone_app/pages/profile_edit/profile_edit_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const DiscordCloneApp());
}

class DiscordCloneApp extends StatelessWidget {
  const DiscordCloneApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Discord Clone',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5562ea)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF5562ea), brightness: Brightness.dark),
          useMaterial3: true,
          brightness: Brightness.dark),
      initialRoute: '/chats',
      onInit: () {
        Get.find<AuthService>().checkUserLoggedIn();
      },
      getPages: [
        GetPage(
            name: '/',
            page: () => InitialPage(),
            binding: InitialPageBindings()),
        GetPage(
            name: '/onboarding',
            page: () => OnboardingPage(),
            binding: OnboardingBindings()),
        GetPage(
            name: '/chats',
            page: () => ChatsPage(),
            binding: ChatsPageBinding()),
        GetPage(
            name: '/chats/:chatId',
            page: () => ChatPage(),
            binding: ChatPageBinding(),
            transition: Transition.cupertino),
        GetPage(
            name: '/profile',
            page: () => ProfilePage(),
            binding: ProfilePageBinding()),
        GetPage(
            name: '/profile/edit',
            page: () => ProfileEditPage(),
            binding: ProfileEditPageBinding(),
            fullscreenDialog: true,
            transition: Transition.downToUp),
        GetPage(
            name: '/profile/friends',
            page: () => FriendsPage(),
            binding: FriendsPageBinding(),
            fullscreenDialog: true,
            transition: Transition.downToUp),
        GetPage(
            name: '/profile/addFriend',
            page: () => AddFriendPage(),
            binding: AddFriendPageBinding(),
            fullscreenDialog: true,
            transition: Transition.downToUp)
      ],
    );
  }
}
