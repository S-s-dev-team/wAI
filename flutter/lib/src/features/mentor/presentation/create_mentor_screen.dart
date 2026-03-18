import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'create_mentor_controller.dart';
import 'create_mentor_contents.dart';

/// CreateMentorContentsとControllerを接続する画面ウィジェット。
/// ルーターからはこのウィジェットを参照する。
class CreateMentorScreen extends ConsumerWidget {
  const CreateMentorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorState = ref.watch(createMentorControllerProvider);

    ref.listen<CreateMentorState>(createMentorControllerProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
      if (next.createdChatId != null && prev?.createdChatId == null) {
        context.go('/chat/${next.createdChatId}');
      }
    });

    return CreateMentorContents(
      isLoading: mentorState.isLoading,
      onSubmit: (input) {
        ref
            .read(createMentorControllerProvider.notifier)
            .createMentor(input);
      },
      onBack: () => context.pop(),
    );
  }
}
