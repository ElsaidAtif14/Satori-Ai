
class ChatMessage {
  final bool isUser;
  final String text;
  final String createdAt;

  const ChatMessage({
    required this.isUser,
    required this.text,
    required this.createdAt,
  });

  ChatMessage.user(String text)
      : this(
          isUser: true,
          text: text,
          createdAt: DateTime.now().toIso8601String(),
        );

  ChatMessage.gemini(String text)
      : this(
          isUser: false,
          text: text,
          createdAt: DateTime.now().toIso8601String(),
        );

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      isUser: map['isUser'] == true,
      text: map['text']?.toString() ?? '',
      createdAt: map['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isUser': isUser,
      'text': text,
      'createdAt': createdAt,
    };
  }
}