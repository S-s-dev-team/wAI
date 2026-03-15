import 'package:flutter/material.dart';
import '../../../shared/widgets/chat_bubble.dart';
import '../../../shared/widgets/chat_input_bar.dart';
import '../widgets/add_senior_overlay.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_message_list.dart';

/// チャット画面（メッセージ詳細）。
///
/// [ChatHeader] + [ChatMessageList] + [ChatInputBar] で構成される。
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.title = 'AI先輩グループチャット',
    this.avatarUrl,
    this.onBack,
    this.initialMessages = const [],
  });

  final String title;
  final String? avatarUrl;
  final VoidCallback? onBack;
  final List<ChatMessage> initialMessages;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final List<ChatMessage> _messages;
  int _nextId = 0;

  @override
  void initState() {
    super.initState();
    _messages = List.of(widget.initialMessages);
  }

  void _handleSend(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(
        id: '${_nextId++}',
        text: text.trim(),
        sender: ChatSender.user,
        senderName: 'あなた',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatHeader(
        title: widget.title,
        avatarUrl: widget.avatarUrl,
        onBack: widget.onBack ?? () => Navigator.maybePop(context),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(child: ChatMessageList(messages: _messages)),
            ChatInputBar(
              onSend: _handleSend,
              onAddSenior: () => showAddSeniorOverlay(
                context: context,
                onConfirm: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
