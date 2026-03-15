import 'package:test/test.dart';
import 'package:wai_api/wai_api.dart';


/// tests for ChatsApi
void main() {
  final instance = WaiApi().getChatsApi();

  group(ChatsApi, () {
    // チャット作成
    //
    // カスタム先輩の情報と一緒にチャットを作成します
    //
    //Future<Chat> createChat(CreateChatRequest createChatRequest) async
    test('test createChat', () async {
      // TODO
    });

    // チャット一覧
    //
    // ログインユーザーのチャット一覧を取得します
    //
    //Future<BuiltList<Chat>> listChats() async
    test('test listChats', () async {
      // TODO
    });

  });
}
