import 'package:flutter/material.dart';
import '../../../core/theme/spacing.dart';

/// 「理想の先輩を作る」フォーム内の1セクション。
///
/// ラベル・任意アイコン・子ウィジェットで構成される汎用レイアウト。
/// [child] には性別トグル・年齢チップ・職種ドロップダウンなど任意の入力UIを渡す。
class MentorFormSection extends StatelessWidget {
  const MentorFormSection({
    super.key,
    required this.label,
    required this.child,
    this.icon,
  });

  final String label;
  final Widget child;

  /// セクションラベル左側に表示するアイコン（省略可）。
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(color: colorScheme.primary, size: 16),
                child: icon!,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(label, style: textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        child,
      ],
    );
  }
}
