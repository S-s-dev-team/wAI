import 'package:flutter/material.dart';
import '../../../core/theme/spacing.dart';
import '../../../shared/widgets/dashboard_card.dart';

/// ダッシュボードのインサイトセクション（価値観・強み・興味など）。
///
/// [DashboardCard.section] をラップし、タグ一覧を [Wrap] で表示する。
/// [items] が空の場合はプレースホルダーテキストを表示する。
class InsightSection extends StatelessWidget {
  const InsightSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    this.onAction,
    this.actionLabel = 'もっと見る',
  });

  final String title;
  final Widget icon;

  /// セクション内に表示するテキストタグの一覧。
  final List<String> items;

  final VoidCallback? onAction;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: title,
      icon: icon,
      onAction: onAction,
      actionLabel: actionLabel,
      child: items.isEmpty
          ? _EmptyState()
          : Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: items.map((item) => _InsightTag(label: item)).toList(),
            ),
    );
  }
}

class _InsightTag extends StatelessWidget {
  const _InsightTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Text(
        label,
        style: textTheme.labelMedium?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      'まだデータがありません',
      style: textTheme.bodySmall?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
