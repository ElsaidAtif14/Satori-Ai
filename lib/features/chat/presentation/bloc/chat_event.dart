abstract class ChatEvent {}

class LoadChatSessionsEvent extends ChatEvent {}

class SelectChatSessionEvent extends ChatEvent {
  final String chatId;
  SelectChatSessionEvent(this.chatId);
}

class StartNewChatEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  SendMessageEvent(this.message);
}
