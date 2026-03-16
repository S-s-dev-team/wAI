import 'package:test/test.dart';
import 'package:wai_api/wai_api.dart';


/// tests for AuthApi
void main() {
  final instance = WaiApi().getAuthApi();

  group(AuthApi, () {
    // ログイン
    //
    // Firebase ID Token を検証し、ユーザーを登録または取得します
    //
    //Future<LoginResponse> login() async
    test('test login', () async {
      // TODO
    });

  });
}
