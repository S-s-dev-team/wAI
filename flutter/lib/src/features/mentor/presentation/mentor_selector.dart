import 'package:flutter/material.dart';
import '../../../constants/spacing.dart';
import '../../../common_widgets/mentor_option_card.dart';

/// [MentorSelector] に渡す選択肢データ。
class MentorSelectorOption {
  const MentorSelectorOption({
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

/// AI先輩の選択肢をリスト表示し、1つだけ選択できるウィジェット。
///
/// 選択状態は呼び出し元で管理する（[selectedId] / [onChanged] で制御）。
class MentorSelector extends StatelessWidget {
  const MentorSelector({
    super.key,
    required this.options,
    required this.selectedId,
    required this.onChanged,
  });

  final List<MentorSelectorOption> options;
  final String? selectedId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          MentorOptionCard(
            icon: options[i].icon,
            title: options[i].title,
            description: options[i].description,
            selected: selectedId == options[i].id,
            onTap: () => onChanged(options[i].id),
          ),
        ],
      ],
    );
  }
}
