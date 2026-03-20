import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

import '../../../api_provider.dart';
import '../../../common_widgets/chat_bubble.dart';
import '../data/message_repository.dart';
import 'chat_message_list.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class ChatState {
  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.hasMore = false,
    this.error,
  });

  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isSending;
  final bool hasMore;
  final String? error;

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isSending,
    bool? hasMore,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final api = ref.watch(waiApiProvider);
  return MessageRepository(api: api);
});

final chatControllerProvider = StateNotifierProvider.autoDispose
    .family<ChatController, ChatState, String>((ref, chatId) {
  final repository = ref.watch(messageRepositoryProvider);
  return ChatController(repository, chatId);
});

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

class ChatController extends StateNotifier<ChatState> {
  final MessageRepository _repository;
  final String chatId;

  ChatController(this._repository, this.chatId) : super(const ChatState()) {
    loadMessages();
  }

  /// メッセージ一覧を取得する。
  Future<void> loadMessages() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getMessages(chatId: chatId);
      final messages = result.messages.map(_toPresentation).toList();
      state = state.copyWith(
        messages: messages,
        hasMore: result.hasMore,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'メッセージの取得に失敗しました',
        isLoading: false,
      );
    }
  }

  /// メッセージを送信し、AI先輩の応答を反映する。
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    state = state.copyWith(isSending: true, error: null);
    try {
      final result = await _repository.sendMessage(
        chatId: chatId,
        content: content.trim(),
      );

      final updated = [
        ...state.messages,
        _toPresentation(result.userMessage),
        ...result.replies.map(_toPresentation),
      ];
      state = state.copyWith(messages: updated, isSending: false);
    } catch (e) {
      state = state.copyWith(
        error: 'メッセージの送信に失敗しました',
        isSending: false,
      );
    }
  }

  /// API の [Message] を presentation の [ChatMessage] に変換する。
  static ChatMessage _toPresentation(Message msg) {
    return ChatMessage(
      id: msg.id,
      text: msg.content,
      sender: msg.senderType == MessageSenderTypeEnum.user
          ? ChatSender.user
          : ChatSender.ai,
      senderName: msg.persona?.name,
      timestamp: msg.createdAt,
    );
  }
}
