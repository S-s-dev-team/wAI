import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

import '../../../api_provider.dart';
import '../data/chat_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class ChatListState {
  const ChatListState({
    this.chats = const [],
    this.isLoading = false,
    this.error,
  });

  final List<Chat> chats;
  final bool isLoading;
  final String? error;

  ChatListState copyWith({
    List<Chat>? chats,
    bool? isLoading,
    String? error,
  }) {
    return ChatListState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final api = ref.watch(waiApiProvider);
  return ChatRepository(api: api);
});

final chatListControllerProvider =
    StateNotifierProvider<ChatListController, ChatListState>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return ChatListController(repository);
});

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

class ChatListController extends StateNotifier<ChatListState> {
  final ChatRepository _repository;

  ChatListController(this._repository) : super(const ChatListState()) {
    loadChats();
  }

  /// チャット一覧を取得する。
  Future<void> loadChats() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final chats = await _repository.listChats();
      state = state.copyWith(chats: chats, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'チャット一覧の取得に失敗しました',
        isLoading: false,
      );
    }
  }
}
