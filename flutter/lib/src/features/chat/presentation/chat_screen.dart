import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/chat_input_bar.dart';
import 'add_senior_overlay.dart';
import 'chat_controller.dart';
import 'chat_header.dart';
import 'chat_message_list.dart';

/// チャット画面（メッセージ詳細）。
///
/// [chatId] を受け取り、API からメッセージを取得・送信する。
/// [ChatHeader] + [ChatMessageList] + [ChatInputBar] で構成される。
class ChatScreen extends ConsumerWidget {
  const ChatScreen({
    super.key,
    required this.chatId,
    this.title = 'AI先輩グループチャット',
    this.avatarUrl,
  });

  final String chatId;
  final String title;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatControllerProvider(chatId));
    final controller = ref.read(chatControllerProvider(chatId).notifier);

    return Scaffold(
      appBar: ChatHeader(
        title: title,
        avatarUrl: avatarUrl,
        onBack: () => Navigator.maybePop(context),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: chatState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : chatState.error != null && chatState.messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(chatState.error!),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () => controller.loadMessages(),
                                child: const Text('再試行'),
                              ),
                            ],
                          ),
                        )
                      : ChatMessageList(messages: chatState.messages),
            ),
            ChatInputBar(
              onSend: (text) => controller.sendMessage(text),
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
