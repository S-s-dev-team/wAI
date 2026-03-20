import 'package:test/test.dart';
import 'package:wai_api/wai_api.dart';


/// tests for InsightsApi
void main() {
  final instance = WaiApi().getInsightsApi();

  group(InsightsApi, () {
    // チャット分析
    //
    // 会話を分析してインサイトを生成・保存します
    //
    //Future<AnalyzeChatResponse> analyzeChat(String chatId) async
    test('test analyzeChat', () async {
      // TODO
    });

    // ダッシュボード取得
    //
    // ユーザーのインサイトをカテゴリ別に返します
    //
    //Future<DashboardResponse> getDashboard() async
    test('test getDashboard', () async {
      // TODO
    });

  });
}
