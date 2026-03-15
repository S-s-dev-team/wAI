import 'package:flutter/material.dart';
import '../../core/theme/spacing.dart';

/// フィルタータブ・カテゴリ選択などに使う Pill 形状のチップ。
///
/// 選択状態に応じて背景色とテキスト色が切り替わる。
/// 色は [ColorScheme] から取得し、インラインカラーは持たない。
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          border: selected
              ? null
              : Border.all(color: colorScheme.outline),
        ),
        child: Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: selected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
