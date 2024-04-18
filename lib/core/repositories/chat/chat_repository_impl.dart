import 'dart:async';
import 'dart:developer';

import 'package:discord_clone_app/core/environment.dart';
import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/models/paginated_result.dart';
import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRepositoryImpl extends GetConnect implements ChatRepository {
  final authRepo = Get.find<AuthRepository>();
  late StreamController<Message> controller = StreamController.broadcast();
  late IO.Socket chatSocket;
  @override
  void onInit() {
    httpClient.baseUrl = Environment.apiUrl;

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await authRepo.getToken();
      if (token != null) {
        request.headers['Authorization'] = token;
      }
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
    httpClient.errorSafety = false;
  }

  @override
  Future<PaginatedResult<Chat>> getChats({int? page}) async {
    final response = await get('/chats', query: {'page': page.toString()});
    if (response.statusCode != 200) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }
    final List<Chat> chats = (response.body['results'] as List<dynamic>)
        .map((e) => Chat.fromJson(e))
        .toList();
    return PaginatedResult(
        total: response.body['total'],
        results: chats,
        page: response.body['page']);
  }

  @override
  Future<PaginatedResult<Message>> getMessages(
      {required String chatId, int? page}) async {
    final response =
        await get('/chats/$chatId/messages', query: {'page': page.toString()});
    if (response.statusCode != 200) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }
    final List<Message> messages = (response.body['results'] as List<dynamic>)
        .map(
          (e) => Message.fromJson(e),
        )
        .toList();
    return PaginatedResult(
        total: response.body['total'],
        results: messages,
        page: int.parse(response.body['page']));
  }

  @override
  Future<Chat> getChat({required String chatId}) async {
    final response = await get('/chats/$chatId');
    if (response.statusCode != 200) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }
    final chat = Chat.fromJson(response.body);
    return chat;
  }

  @override
  Future<void> sendMessage(
      {required String chatId, required String content}) async {
    final response =
        await post('/chats/$chatId/messages', {'content': content});

    if (response.statusCode != 201) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }
  }

  @override
  Future<void> connectToChat({required String chatId}) async {
    final token = await authRepo.getToken();
    chatSocket = IO.io(
        Environment.apiUrl,
        IO.OptionBuilder()
            .setExtraHeaders({'authorization': token})
            .setReconnectionAttempts(3)
            .disableAutoConnect()
            .setTransports(
              ['websocket'],
            )
            .build());
    chatSocket.connect();
    if (controller.isClosed) {
      controller = StreamController.broadcast();
    }
    chatSocket.onConnectError((data) => log("connection error $data"));
    chatSocket.emit('joinChat', {'chatId': chatId});
    chatSocket.on('unauthorized', (data) {
      log("Not connected to chat", name: "ChatRepository");
      if (!controller.isClosed) {
        controller.close();
      }
    });
    chatSocket.on('success', (data) {
      log("connected to chat", name: "ChatRepository");
    });
    chatSocket.on('newMessage', (data) {
      controller.add(Message.fromJson(data));
      log("New message received", name: "ChatRepository");
    });
  }

  @override
  Stream<Message> get messagesStream => controller.stream;

  @override
  void disconnectFromChat() {
    if (!controller.isClosed) {
      controller.close();
    }
    chatSocket.disconnect();
    chatSocket.dispose();
    chatSocket.close();
  }

  @override
  Future<Chat?> getChatWith({required String chatWith}) async {
    final response =
        await get('/chats', query: {'page': 1.toString(), 'with': chatWith});

    if (response.statusCode != 200) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }

    if ((response.body['results'] as List<dynamic>).isEmpty) {
      return null;
    }

    final chats = (response.body['results'] as List<dynamic>)
        .map((e) => Chat.fromJson(e))
        .toList();
    return chats[0];
  }

  @override
  Future<Chat> createChat(
      {required String myProfile, required String chatWith}) async {
    final response = await post('/chats', {
      'members': [myProfile, chatWith]
    });

    if (response.statusCode != 200) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }
    final chat = Chat.fromJson(response.body);
    return chat;
  }

  @override
  Future<void> deleteMessage({required String chatId, required String messageId}) async {
    final response = await delete('/chats/$chatId/messages/$messageId');
    
    if (response.statusCode != 200) {
      log('Response status code: ${response.statusCode}',
          name: 'ChatRepository');
      log('Response body: ${response.body}', name: 'ChatRepository');
      throw ('An error has ocurred');
    }
    
  }
}
