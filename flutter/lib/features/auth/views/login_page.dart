import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/auth_view_model.dart';
import 'login_screen.dart';

/// LoginScreenとViewModelを接続するページウィジェット。
/// ルーターからはこのウィジェットを参照する。
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return LoginScreen(
      isLoading: authState.isLoading,
      onGoogleLogin: () {
        ref.read(authViewModelProvider.notifier).signInWithGoogle();
      },
    );
  }
}
