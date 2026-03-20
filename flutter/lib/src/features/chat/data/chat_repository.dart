import 'package:wai_api/wai_api.dart';

class ChatRepository {
  final WaiApi _api;

  ChatRepository({required WaiApi api}) : _api = api;

  /// チャット一覧を取得する。
  Future<List<Chat>> listChats() async {
    final response = await _api.getChatsApi().listChats();

    final data = response.data;
    if (data == null) {
      throw Exception('チャット一覧の取得に失敗しました');
    }
    return data.toList();
  }
}
