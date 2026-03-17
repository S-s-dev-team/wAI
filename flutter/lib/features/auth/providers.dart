import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

import 'notifiers/auth_notifier.dart';
import 'services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final waiApiProvider = Provider<WaiApi>((ref) {
  return WaiApi();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final api = ref.watch(waiApiProvider);
  return AuthNotifier(authService, api);
});
