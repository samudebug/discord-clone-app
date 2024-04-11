import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/models/paginated_result.dart';

abstract class ChatRepository {
  Future<PaginatedResult<Chat>> getChats({int? page});
  Future<PaginatedResult<Message>> getMessages({required String chatId,int? page});
  Future<Chat> getChat({required String chatId});
}