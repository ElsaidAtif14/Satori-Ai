import 'package:flutter/material.dart';

class EmptyChatPlaceholder extends StatelessWidget {
  const EmptyChatPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 48,
            color: Colors.cyanAccent.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'ابدأ محادثة ذكية مع Gemini الآن',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
