import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';

/// 先輩選択ボトムシートで使うオプションカード。
///
/// 選択中は [ColorScheme.primary] のボーダーと薄い背景、
/// 非選択中はデフォルトのボーダー色で描画される。
class MentorOptionCard extends StatelessWidget {
  const MentorOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final borderColor =
        selected ? colorScheme.primary : const Color(0xFFE2E8F0);
    final backgroundColor =
        selected ? colorScheme.primaryContainer.withOpacity(0.5) : colorScheme.surface;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TitleRow(icon: icon, title: title, selected: selected),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            _RadioIndicator(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.icon,
    required this.title,
    required this.selected,
  });

  final Widget icon;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final iconColor =
        selected ? colorScheme.primary : AppColors.textSecondary;

    return Row(
      children: [
        IconTheme(
          data: IconThemeData(color: iconColor, size: 18),
          child: icon,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: selected ? 28 : 24,
      height: selected ? 28 : 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? colorScheme.primary : Colors.transparent,
        border: Border.all(
          color: selected ? colorScheme.primary : colorScheme.outline,
          width: 2,
        ),
      ),
      child: selected
          ? Icon(
              Icons.check,
              size: 14,
              color: colorScheme.onPrimary,
            )
          : null,
    );
  }
}
