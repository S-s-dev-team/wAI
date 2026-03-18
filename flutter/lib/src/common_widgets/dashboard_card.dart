import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';

/// ダッシュボード共通カード。
///
/// 用途に応じて2つのコンストラクタを使い分ける:
///
/// - [DashboardCard.section] : タイトル付きセクション（価値観・強み・興味など）
/// - [DashboardCard.stat]    : 単一指標の数値カード（分析完了数・インサイト数など）
class DashboardCard extends StatelessWidget {
  /// タイトル・アイコン・アクションを持つセクションカード。
  const DashboardCard.section({
    super.key,
    required this.title,
    required this.child,
    this.icon,
    this.onAction,
    this.actionLabel = 'もっと見る',
  })  : _variant = _Variant.section,
        label = null,
        value = null,
        trend = null,
        isTrendPositive = null;

  /// 指標ラベル・数値・増減トレンドを表示するコンパクトな統計カード。
  const DashboardCard.stat({
    super.key,
    required this.label,
    required this.value,
    required this.trend,
    required this.isTrendPositive,
  })  : _variant = _Variant.stat,
        title = null,
        child = null,
        icon = null,
        onAction = null,
        actionLabel = null;

  final _Variant _variant;

  // section
  final String? title;
  final Widget? child;
  final Widget? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  // stat
  final String? label;
  final String? value;
  final String? trend;
  final bool? isTrendPositive;

  @override
  Widget build(BuildContext context) {
    return switch (_variant) {
      _Variant.section => _SectionCard(
          title: title!,
          icon: icon,
          onAction: onAction,
          actionLabel: actionLabel!,
          child: child!,
        ),
      _Variant.stat => _StatCard(
          label: label!,
          value: value!,
          trend: trend!,
          isTrendPositive: isTrendPositive!,
        ),
    };
  }
}

enum _Variant { section, stat }

// ---------------------------------------------------------------------------
// Section Card
// ---------------------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    required this.actionLabel,
    this.icon,
    this.onAction,
  });

  final String title;
  final Widget child;
  final String actionLabel;
  final Widget? icon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Row(
              children: [
                if (icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: colorScheme.primary,
                      size: 18,
                    ),
                    child: icon!,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium,
                  ),
                ),
                if (onAction != null)
                  TextButton(
                    onPressed: onAction,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(actionLabel),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat Card
// ---------------------------------------------------------------------------

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.trend,
    required this.isTrendPositive,
  });

  final String label;
  final String value;
  final String trend;
  final bool isTrendPositive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: textTheme.displayLarge),
              const SizedBox(width: AppSpacing.xs),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: _TrendBadge(
                  trend: trend,
                  isPositive: isTrendPositive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  const _TrendBadge({required this.trend, required this.isPositive});

  final String trend;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final color = isPositive
        ? _kPositiveColor
        : colorScheme.error;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
          size: 12,
          color: color,
        ),
        Text(
          trend,
          style: textTheme.labelSmall?.copyWith(color: color),
        ),
      ],
    );
  }
}

/// ポジティブトレンドの色。
const Color _kPositiveColor = AppColors.success;
