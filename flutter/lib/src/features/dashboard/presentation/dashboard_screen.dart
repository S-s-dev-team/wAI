import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../constants/text_styles.dart';
import '../../../common_widgets/app_bottom_navigation.dart';
import '../../../common_widgets/app_chip.dart';
import '../../../common_widgets/dashboard_card.dart';
import 'insight_metric_row.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

class CoreValueData {
  const CoreValueData({
    required this.badge,
    required this.timestamp,
    required this.title,
    required this.description,
  });

  final String badge;
  final String timestamp;
  final String title;
  final String description;
}

class StrengthData {
  const StrengthData({
    required this.icon,
    required this.name,
    required this.description,
  });

  final IconData icon;
  final String name;
  final String description;
}

class InsightQuoteData {
  const InsightQuoteData({
    required this.text,
    required this.label,
    this.isFeatured = false,
  });

  final String text;
  final String label;
  final bool isFeatured;
}

// ---------------------------------------------------------------------------
// Category filter enum
// ---------------------------------------------------------------------------

enum _Category {
  all('すべて'),
  coreValues('価値観'),
  strengths('強み'),
  interests('興味'),
  insights('気づき');

  const _Category(this.label);
  final String label;
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// 自己分析ダッシュボード画面。
///
/// - 指標カード（InsightMetricRow）
/// - カテゴリフィルターチップ
/// - 価値観 / 強み / 興味 / 最新の気づき セクション
/// - BottomNavigation（ダッシュボードタブ選択中）
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.analysisCount,
    required this.analysisTrend,
    required this.analysisTrendPositive,
    required this.insightCount,
    required this.insightTrend,
    required this.insightTrendPositive,
    required this.coreValue,
    required this.strengths,
    required this.interests,
    required this.insightQuotes,
    this.onValuesAction,
    this.onNavTap,
    this.currentNavIndex = 1,
  });

  // Metrics
  final String analysisCount;
  final String analysisTrend;
  final bool analysisTrendPositive;
  final String insightCount;
  final String insightTrend;
  final bool insightTrendPositive;

  // Section data
  final CoreValueData coreValue;
  final List<StrengthData> strengths;
  final List<String> interests;
  final List<InsightQuoteData> insightQuotes;

  final VoidCallback? onValuesAction;
  final ValueChanged<int>? onNavTap;
  final int currentNavIndex;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  _Category _category = _Category.all;

  bool get _showValues =>
      _category == _Category.all || _category == _Category.coreValues;
  bool get _showStrengths =>
      _category == _Category.all || _category == _Category.strengths;
  bool get _showInterests =>
      _category == _Category.all || _category == _Category.interests;
  bool get _showInsights =>
      _category == _Category.all || _category == _Category.insights;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _DashboardAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePadding,
          vertical: AppSpacing.lg,
        ),
        children: [
          InsightMetricRow(
            primaryLabel: '分析完了数',
            primaryValue: widget.analysisCount,
            primaryTrend: widget.analysisTrend,
            primaryTrendPositive: widget.analysisTrendPositive,
            secondaryLabel: 'インサイト数',
            secondaryValue: widget.insightCount,
            secondaryTrend: widget.insightTrend,
            secondaryTrendPositive: widget.insightTrendPositive,
          ),
          const SizedBox(height: AppSpacing.md),
          _CategoryFilterRow(
            selected: _category,
            onChanged: (c) => setState(() => _category = c),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_showValues) ...[
            _ValuesSection(
              data: widget.coreValue,
              onAction: widget.onValuesAction,
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_showStrengths) ...[
            _StrengthsSection(strengths: widget.strengths),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_showInterests) ...[
            _InterestsSection(interests: widget.interests),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_showInsights) ...[
            _InsightsSection(quotes: widget.insightQuotes),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: widget.currentNavIndex,
        items: const [
          AppBottomNavItem(
            label: 'メッセージ',
            icon: Icon(Icons.chat_bubble_outline_rounded),
            activeIcon: Icon(Icons.chat_bubble_rounded),
          ),
          AppBottomNavItem(
            label: 'ダッシュボード',
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view_rounded),
          ),
          AppBottomNavItem(
            label: '設定',
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings_rounded),
          ),
        ],
        onTap: (i) => widget.onNavTap?.call(i),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------

class _DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      centerTitle: true,
      title: Text('自己分析ダッシュボード', style: textTheme.titleMedium),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(
              Icons.person_rounded,
              size: 22,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Category filter chips
// ---------------------------------------------------------------------------

class _CategoryFilterRow extends StatelessWidget {
  const _CategoryFilterRow({
    required this.selected,
    required this.onChanged,
  });

  final _Category selected;
  final ValueChanged<_Category> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _Category.values
            .map(
              (cat) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: AppChip(
                  label: cat.label,
                  selected: selected == cat,
                  onTap: () => onChanged(cat),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 価値観 section
// ---------------------------------------------------------------------------

class _ValuesSection extends StatelessWidget {
  const _ValuesSection({required this.data, this.onAction});

  final CoreValueData data;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: '価値観 (Values)',
      icon: const Icon(Icons.favorite_border_rounded),
      onAction: onAction,
      child: _CoreValueCard(data: data),
    );
  }
}

class _CoreValueCard extends StatelessWidget {
  const _CoreValueCard({required this.data});

  final CoreValueData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  data.badge,
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.primary,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                data.timestamp,
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(data.title, style: textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            data.description,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 強み section
// ---------------------------------------------------------------------------

class _StrengthsSection extends StatelessWidget {
  const _StrengthsSection({required this.strengths});

  final List<StrengthData> strengths;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: '強み (Strengths)',
      icon: const Icon(Icons.bolt_rounded),
      child: strengths.isEmpty
          ? _EmptyHint()
          : _StrengthGrid(strengths: strengths),
    );
  }
}

class _StrengthGrid extends StatelessWidget {
  const _StrengthGrid({required this.strengths});

  final List<StrengthData> strengths;

  @override
  Widget build(BuildContext context) {
    // Pair up strengths into rows of 2
    final rows = <List<StrengthData>>[];
    for (int i = 0; i < strengths.length; i += 2) {
      rows.add(strengths.sublist(i, (i + 2).clamp(0, strengths.length)));
    }

    return Column(
      children: [
        for (int i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: _StrengthCard(data: rows[i][0])),
              if (rows[i].length > 1) ...[
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _StrengthCard(data: rows[i][1])),
              ] else
                const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ],
    );
  }
}

class _StrengthCard extends StatelessWidget {
  const _StrengthCard({required this.data});

  final StrengthData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, size: 18, color: colorScheme.primary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(data.name, style: textTheme.labelLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(
            data.description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 興味 section
// ---------------------------------------------------------------------------

class _InterestsSection extends StatelessWidget {
  const _InterestsSection({required this.interests});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: '興味 (Interests)',
      icon: const Icon(Icons.auto_awesome_rounded),
      child: interests.isEmpty
          ? _EmptyHint()
          : _BulletItemList(items: interests),
    );
  }
}

class _BulletItemList extends StatelessWidget {
  const _BulletItemList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // Two-column wrap layout matching Figma
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(item, style: textTheme.bodyMedium),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// 最新の気づき section
// ---------------------------------------------------------------------------

class _InsightsSection extends StatelessWidget {
  const _InsightsSection({required this.quotes});

  final List<InsightQuoteData> quotes;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: '最新の気づき (Insights)',
      icon: const Icon(Icons.lightbulb_outline_rounded),
      child: quotes.isEmpty
          ? _EmptyHint()
          : Column(
              children: [
                for (int i = 0; i < quotes.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.sm),
                  quotes[i].isFeatured
                      ? _FeaturedInsightCard(data: quotes[i])
                      : _InsightCard(data: quotes[i]),
                ],
              ],
            ),
    );
  }
}

class _FeaturedInsightCard extends StatelessWidget {
  const _FeaturedInsightCard({required this.data});

  final InsightQuoteData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            colorScheme.primary.withOpacity(0.1),
            colorScheme.primary.withOpacity(0.0),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left accent border
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.radiusMd),
                  bottomLeft: Radius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.text,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Text(
                          data.label,
                          style: AppTextStyles.caption.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.ios_share_rounded,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.data});

  final InsightQuoteData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.text, style: textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            data.label,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared empty hint
// ---------------------------------------------------------------------------

class _EmptyHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'まだデータがありません',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}
