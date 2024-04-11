import 'dart:developer';

import 'package:discord_clone_app/core/environment.dart';
import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/models/paginated_result.dart';
import 'package:discord_clone_app/core/repositories/auth/auth_repository.dart';
import 'package:discord_clone_app/core/repositories/chat/chat_repository.dart';
import 'package:get/get.dart';

class ChatRepositoryImpl extends GetConnect implements ChatRepository {
  final authRepo = Get.find<AuthRepository>();
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
        page: int.parse(response.body['page']));
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
}
