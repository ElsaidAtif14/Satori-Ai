import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:test_ai/features/chat/data/models/chat_message.dart';


class MessageBubble extends StatelessWidget {
  static const _cardBg = Color(0xFF1E1E20);
  static const _userAccent = Color(0xFF1A73E8);

  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final textDirection = _textDirectionFor(message.text);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? _userAccent : _cardBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 16),
          ),
        ),
        child: Directionality(
          textDirection: textDirection,
          child: isUser ? _buildUserText() : _buildGeminiMarkdown(context),
        ),
      ),
    );
  }

  Widget _buildUserText() {
    return Text(
      message.text,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  Widget _buildGeminiMarkdown(BuildContext context) {
    return MarkdownBody(
      data: message.text,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
        strong: const TextStyle(
          color: Colors.cyanAccent,
          fontWeight: FontWeight.bold,
        ),
        listBullet: const TextStyle(color: Colors.cyanAccent),
      ),
    );
  }

  TextDirection _textDirectionFor(String text) {
    final rtlCharacters = RegExp(r'[\u0591-\u07FF\uFB1D-\uFDFD\uFE70-\uFEFC]');
    return rtlCharacters.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}
