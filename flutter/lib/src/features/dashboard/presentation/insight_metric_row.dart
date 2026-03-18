import 'package:flutter/material.dart';
import '../../../constants/spacing.dart';
import '../../../common_widgets/dashboard_card.dart';

/// ダッシュボード上部の2つの指標を横並びで表示するウィジェット。
///
/// Figmaの「分析完了数 / インサイト数」レイアウトに対応。
/// 各指標は [DashboardCard.stat] でレンダリングされる。
class InsightMetricRow extends StatelessWidget {
  const InsightMetricRow({
    super.key,
    required this.primaryLabel,
    required this.primaryValue,
    required this.primaryTrend,
    required this.primaryTrendPositive,
    required this.secondaryLabel,
    required this.secondaryValue,
    required this.secondaryTrend,
    required this.secondaryTrendPositive,
  });

  final String primaryLabel;
  final String primaryValue;
  final String primaryTrend;
  final bool primaryTrendPositive;

  final String secondaryLabel;
  final String secondaryValue;
  final String secondaryTrend;
  final bool secondaryTrendPositive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DashboardCard.stat(
            label: primaryLabel,
            value: primaryValue,
            trend: primaryTrend,
            isTrendPositive: primaryTrendPositive,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: DashboardCard.stat(
            label: secondaryLabel,
            value: secondaryValue,
            trend: secondaryTrend,
            isTrendPositive: secondaryTrendPositive,
          ),
        ),
      ],
    );
  }
}
