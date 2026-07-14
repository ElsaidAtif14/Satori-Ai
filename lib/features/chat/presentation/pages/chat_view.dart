import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ai/core/utils/app_colors.dart';
import 'package:test_ai/core/utils/text_styles.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_drawer.dart';
import '../widgets/chat_input_area.dart';
import '../widgets/chat_loading_indicator.dart';
import '../widgets/chat_messages_list.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<ChatBloc>().add(LoadChatSessionsEvent());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131314),
      appBar: const ChatAppBar(),
      drawer: const ChatDrawer(),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: _onChatStateChanged,
        builder: (context, state) {
          final messages = state.messages;
          final isLoading = state is ChatSessionsLoading || state is ChatSendingMessage;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ChatMessagesList(
                    messages: messages,
                    scrollController: _scrollController,
                  ),
                ),
                if (isLoading) const ChatLoadingIndicator(),
                ChatInputArea(onSend: _sendMessage),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onChatStateChanged(BuildContext context, ChatState state) {
    if (state is ChatFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage, style: TextStyles.regular14),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    if (state is ChatLoaded) {
      _scrollToBottom();
    }
  }

  void _sendMessage(String text) {
    context.read<ChatBloc>().add(SendMessageEvent(text));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.positions.isNotEmpty) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
