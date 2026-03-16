import 'package:test/test.dart';
import 'package:wai_api/wai_api.dart';


/// tests for MessagesApi
void main() {
  final instance = WaiApi().getMessagesApi();

  group(MessagesApi, () {
    // メッセージ一覧
    //
    // チャット内のメッセージ一覧を取得します
    //
    //Future<MessageList> listMessages(String chatId, { int limit, String before }) async
    test('test listMessages', () async {
      // TODO
    });

    // メッセージ送信
    //
    // ユーザーのメッセージを送信し、AI先輩からの応答を返します
    //
    //Future<SendMessageResponse> sendMessage(String chatId, SendMessageRequest sendMessageRequest) async
    test('test sendMessage', () async {
      // TODO
    });

  });
}
