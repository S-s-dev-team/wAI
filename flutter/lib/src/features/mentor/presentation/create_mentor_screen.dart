import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        // TODO: チャット画面への遷移（チャット画面のルート実装後）
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('先輩を作成しました')),
        );
      }
    });

    return CreateMentorContents(
      isLoading: mentorState.isLoading,
      onSubmit: (input) {
        ref
            .read(createMentorControllerProvider.notifier)
            .createMentor(input);
      },
      onBack: () => Navigator.maybePop(context),
    );
  }
}
