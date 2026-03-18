import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

/// アプリ全体で共有する [WaiApi] インスタンス。
/// 認証トークンの設定がすべてのAPI呼び出しに反映される。
final waiApiProvider = Provider<WaiApi>((ref) {
  return WaiApi();
});
