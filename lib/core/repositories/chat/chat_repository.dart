import 'package:discord_clone_app/core/models/chat.dart';
import 'package:discord_clone_app/core/models/message.dart';
import 'package:discord_clone_app/core/models/paginated_result.dart';

abstract class ChatRepository {
  Future<PaginatedResult<Chat>> getChats({int? page});
  Future<PaginatedResult<Message>> getMessages({required String chatId,int? page});
  Future<Chat> getChat({required String chatId});
  Future<Chat?> getChatWith({required String chatWith});
  Future<Chat> createChat({required String myProfile, required String chatWith});
  // messages
  Future<void> sendMessage({required String chatId,required String content});
  Future<void> connectToChat({required String chatId});
  Future<void> deleteMessage({required String chatId, required String messageId});
  Stream<Message> get messagesStream;
  void disconnectFromChat();
}