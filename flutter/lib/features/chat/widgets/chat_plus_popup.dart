import 'package:flutter/material.dart';
import '../../../core/theme/spacing.dart';
import '../../../shared/widgets/app_primary_button.dart';
import '../../../shared/widgets/mentor_option_card.dart';

/// 「先輩を追加する」ポップアップに渡すメンター選択肢。
class ChatMentorOption {
  const ChatMentorOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String id;
  final Widget icon;
  final String title;
  final String description;
}

/// チャット画面の「+」タップ時に表示するボトムシートコンテンツ。
///
/// [options] の中から1つ選択し、[onConfirm] でそのIDを返す。
/// [showChatPlusPopup] ヘルパーでモーダルとして表示する。
class ChatPlusPopup extends StatefulWidget {
  const ChatPlusPopup({
    super.key,
    required this.options,
    required this.onConfirm,
    this.onClose,
  });

  final List<ChatMentorOption> options;
  final ValueChanged<String> onConfirm;
  final VoidCallback? onClose;

  @override
  State<ChatPlusPopup> createState() => _ChatPlusPopupState();
}

class _ChatPlusPopupState extends State<ChatPlusPopup> {
  String? _selectedId;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.pagePadding,
        AppSpacing.lg,
        AppSpacing.pagePadding,
        AppSpacing.xl + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('先輩を追加する', style: textTheme.titleMedium),
              IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                onPressed:
                    widget.onClose ?? () => Navigator.of(context).pop(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'チャットに参加させるAI先輩を選択してください。',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.md),
          ...widget.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: MentorOptionCard(
                icon: option.icon,
                title: option.title,
                description: option.description,
                selected: _selectedId == option.id,
                onTap: () => setState(() => _selectedId = option.id),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppPrimaryButton(
            label: '先輩を追加してチャットを始める',
            onPressed: _selectedId != null
                ? () => widget.onConfirm(_selectedId!)
                : null,
          ),
        ],
      ),
    );
  }
}

/// [ChatPlusPopup] をモーダルボトムシートとして表示するヘルパー。
Future<void> showChatPlusPopup({
  required BuildContext context,
  required List<ChatMentorOption> options,
  required ValueChanged<String> onConfirm,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSpacing.radiusBottomSheet),
      ),
    ),
    builder: (_) => ChatPlusPopup(
      options: options,
      onConfirm: (id) {
        Navigator.of(context).pop();
        onConfirm(id);
      },
    ),
  );
}
