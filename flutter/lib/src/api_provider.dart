import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

/// アプリ全体で共有する [WaiApi] インスタンス。
/// [FirebaseAuthInterceptor] により Bearer トークンが自動付与される。
final waiApiProvider = Provider<WaiApi>((ref) {
  final api = WaiApi(basePathOverride: _apiBaseUrl);
  api.dio.interceptors.add(FirebaseAuthInterceptor());
  return api;
});

/// 毎リクエスト時に Firebase の ID トークンを Authorization ヘッダーに付与する。
/// アプリ再起動後やトークン期限切れ時にも自動でリフレッシュされる。
class FirebaseAuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {
      // トークン取得失敗時はヘッダーなしで続行（未ログイン時など）
    }
    handler.next(options);
  }
}
