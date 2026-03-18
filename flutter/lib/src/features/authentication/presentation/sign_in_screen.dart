import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_in_controller.dart';
import 'sign_in_contents.dart';

/// SignInContentsとControllerを接続する画面ウィジェット。
/// ルーターからはこのウィジェットを参照する。
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(signInControllerProvider);

    ref.listen<AuthState>(signInControllerProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    return SignInContents(
      isLoading: authState.isLoading,
      onGoogleLogin: () {
        ref.read(signInControllerProvider.notifier).signInWithGoogle();
      },
    );
  }
}
