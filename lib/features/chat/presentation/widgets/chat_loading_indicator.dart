import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatLoadingIndicator extends StatelessWidget {
  const ChatLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CupertinoActivityIndicator(color: Colors.cyanAccent),
          ),
          const SizedBox(width: 10),
          Text(
            'Satori is thinking...',
            style:  GoogleFonts.cairo(
        color: Colors.white,           // لون أبيض صريح
        fontSize: 15.5,                // نفس حجم خط ردود جيمناي
        fontWeight: FontWeight.w600,   // وزن عريض (Semi-Bold) يمنع الرفع والبهتان
        height: 1.4,                   // مسافة مريحة بين الأسطر بالعربي
      ),
          ),
        ],
      ),
    );
  }
}
