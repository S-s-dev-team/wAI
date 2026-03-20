import 'package:wai_api/wai_api.dart';

class MessageRepository {
  final WaiApi _api;

  MessageRepository({required WaiApi api}) : _api = api;

  /// チャット内のメッセージ一覧を取得する。
  Future<MessageList> getMessages({
    required String chatId,
    int limit = 50,
    String? before,
  }) async {
    final response = await _api.getMessagesApi().listMessages(
          chatId: chatId,
          limit: limit,
          before: before,
        );

    final data = response.data;
    if (data == null) {
      throw Exception('メッセージ一覧の取得に失敗しました');
    }
    return data;
  }

  /// メッセージを送信し、AI先輩の応答を含むレスポンスを返す。
  Future<SendMessageResponse> sendMessage({
    required String chatId,
    required String content,
  }) async {
    final response = await _api.getMessagesApi().sendMessage(
          chatId: chatId,
          sendMessageRequest: SendMessageRequest((b) => b..content = content),
        );

    final data = response.data;
    if (data == null) {
      throw Exception('メッセージの送信に失敗しました');
    }
    return data;
  }

  /// プリセット先輩を呼び出し、応答メッセージを返す。
  Future<Message> callPersona({
    required String chatId,
    required String presetKey,
  }) async {
    final response = await _api.getMessagesApi().callPersona(
          chatId: chatId,
          callPersonaRequest: CallPersonaRequest(
            (b) => b
              ..presetKey = CallPersonaRequestPresetKeyEnum.valueOf(presetKey),
          ),
        );

    final data = response.data;
    if (data == null) {
      throw Exception('先輩の呼び出しに失敗しました');
    }
    return data;
  }
}
