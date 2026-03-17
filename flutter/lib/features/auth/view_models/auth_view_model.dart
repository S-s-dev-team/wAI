import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/auth_repository.dart';

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

// --- Providers ---

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});

// --- ViewModel ---

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  StreamSubscription<User?>? _authSub;

  AuthViewModel(this._repository) : super(const AuthState()) {
    _authSub = _repository.authStateChanges.listen(_onAuthStateChanged);
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
      final user = await _repository.signInWithGoogle();
      if (user == null) {
        state = state.copyWith(isLoading: false);
        return;
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
    await _repository.signOut();
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
