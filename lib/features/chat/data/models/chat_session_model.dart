class ChatSessionModel {
  final String id;
  final String title;
  final String createdAt;

  ChatSessionModel({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory ChatSessionModel.fromMap(Map<String, dynamic> map) {
    return ChatSessionModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? 'New Chat',
      createdAt: map['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': createdAt,
    };
  }
}
