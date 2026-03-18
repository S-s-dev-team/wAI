import 'package:flutter/material.dart';
import '../../../constants/spacing.dart';
import '../../../common_widgets/chat_bubble.dart';

/// チャットメッセージのデータモデル。
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    this.senderName,
    this.avatarUrl,
    this.timestamp,
  });

  final String id;
  final String text;
  final ChatSender sender;

  /// AI先輩の表示名（例: 「やりがい重視先輩」「分析・戦略先輩」）。
  final String? senderName;

  /// AI先輩のアバター画像URL。
  final String? avatarUrl;
  final DateTime? timestamp;
}

/// チャット画面のメッセージ一覧。
///
/// [messages] を [ChatBubble] でレンダリングするスクロール可能なリスト。
/// メッセージが追加されると自動的に最下部へスクロールする。
class ChatMessageList extends StatefulWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    this.padding,
  });

  final List<ChatMessage> messages;
  final EdgeInsetsGeometry? padding;

  @override
  State<ChatMessageList> createState() => _ChatMessageListState();
}

class _ChatMessageListState extends State<ChatMessageList> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(ChatMessageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length != oldWidget.messages.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.pagePadding,
            vertical: AppSpacing.md,
          ),
      itemCount: widget.messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final msg = widget.messages[index];
        return ChatBubble(
          message: msg.text,
          sender: msg.sender,
          senderName: msg.senderName,
          avatarUrl: msg.avatarUrl,
        );
      },
    );
  }
}
