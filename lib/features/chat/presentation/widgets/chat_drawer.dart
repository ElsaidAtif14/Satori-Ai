import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ai/core/helper/get_user.dart';
import 'package:test_ai/core/routing/routes.dart';
import 'package:test_ai/core/services/firebase_auth_services.dart';
import 'package:test_ai/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:test_ai/features/chat/presentation/bloc/chat_event.dart';
import 'package:test_ai/features/chat/presentation/bloc/chat_state.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUser();

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        user.imageUrl != null && user.imageUrl!.isNotEmpty
                            ? NetworkImage(user.imageUrl!) as ImageProvider
                            : const AssetImage('assets/images/icons/email_Icon.svg'),
                    backgroundColor: Colors.grey.shade900,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.isNotEmpty ? user.name : 'Satori User',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: const Color(0xFF1A73E8),
                ),
                icon: const Icon(Icons.add),
                label: const Text('New Chat'),
                onPressed: () {
                  context.read<ChatBloc>().add(StartNewChatEvent());
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent chats',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  final sessions = state is ChatLoaded ? state.sessions : const [];
                  final activeChatId = state is ChatLoaded ? state.activeChatId : null;

                  if (state is ChatSessionsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (sessions.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No chats yet. Start a new conversation to save your history.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (context, index) {
                      final session = sessions[index];
                      final selected = session.id == activeChatId;
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: selected ? Colors.blueAccent.withOpacity(0.15) : Colors.grey.shade900,
                        title: Text(
                          session.title,
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.white70,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          session.createdAt,
                          style: const TextStyle(color: Colors.white38, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          context.read<ChatBloc>().add(SelectChatSessionEvent(session.id));
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemCount: sessions.length,
                  );
                },
              ),
            ),
            const Divider(color: Colors.white12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Colors.white70),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await FirebaseAuthServices().signOut();
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginView,
                            (route) => false,
                          );
                        }
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
