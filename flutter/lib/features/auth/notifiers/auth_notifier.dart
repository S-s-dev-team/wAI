import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

import '../services/auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final WaiApi _api;
  StreamSubscription<User?>? _authSub;

  AuthNotifier(this._authService, this._api) : super(const AuthState()) {
    _authSub = _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) {
    if (user != null) {
      state = state.copyWith(status: AuthStatus.authenticated);
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _authService.signInWithGoogle();
      if (user == null) {
        // ユーザーがキャンセル
        state = state.copyWith(isLoading: false);
        return;
      }

      // Firebase IDトークンを取得してバックエンドAPIを呼び出す
      final idToken = await _authService.getIdToken();
      if (idToken != null) {
        _api.setBearerAuth('BearerAuth', idToken);
        await _api.getAuthApi().login();
      }

      state = state.copyWith(
        status: AuthStatus.authenticated,
        isLoading: false,
      );
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message ?? '認証に失敗しました',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'ログインに失敗しました',
      );
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
