import 'package:flutter/material.dart';
import 'package:test_ai/core/helper/get_user.dart';
import 'package:test_ai/core/widgets/blue_dot.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: CircleAvatar(
            backgroundImage: getUser().imageUrl != null && getUser().imageUrl!.isNotEmpty
                ? NetworkImage(getUser().imageUrl!)
                : null,
            child: getUser().imageUrl == null || getUser().imageUrl!.isEmpty
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
        ),
      ),

      title: const Row(

        mainAxisSize: MainAxisSize.min,
        children: [BlueDot(), SizedBox(width: 8), Text('Satori AI Assistant')],
      ),
    );
  }
}
