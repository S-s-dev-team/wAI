import 'package:wai_api/wai_api.dart';

class DashboardRepository {
  final WaiApi _api;

  DashboardRepository({required WaiApi api}) : _api = api;

  /// ダッシュボード情報を取得する。
  Future<DashboardResponse> getDashboard() async {
    final response = await _api.getInsightsApi().getDashboard();

    final data = response.data;
    if (data == null) {
      throw Exception('ダッシュボード情報の取得に失敗しました');
    }
    return data;
  }

  /// チャットを分析してインサイトを生成する。
  Future<AnalyzeChatResponse> analyzeChat({
    required String chatId,
  }) async {
    final response = await _api.getInsightsApi().analyzeChat(chatId: chatId);

    final data = response.data;
    if (data == null) {
      throw Exception('チャット分析に失敗しました');
    }
    return data;
  }
}
