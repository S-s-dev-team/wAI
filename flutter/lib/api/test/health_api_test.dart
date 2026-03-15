import 'package:test/test.dart';
import 'package:wai_api/wai_api.dart';


/// tests for HealthApi
void main() {
  final instance = WaiApi().getHealthApi();

  group(HealthApi, () {
    // ヘルスチェック
    //
    // アプリケーションのヘルスステータスを確認します
    //
    //Future<HealthResponse> healthCheck() async
    test('test healthCheck', () async {
      // TODO
    });

  });
}
