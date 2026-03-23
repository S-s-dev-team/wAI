import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wai_api/wai_api.dart';

import '../../../constants/spacing.dart';
import '../../../constants/text_styles.dart';
import '../../../common_widgets/app_bottom_navigation.dart';
import '../../../common_widgets/app_chip.dart';
import '../../../common_widgets/dashboard_card.dart';
import 'dashboard_controller.dart';
import 'insight_metric_row.dart';

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

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  _Category _category = _Category.all;

  bool _shouldShow(_Category cat) =>
      _category == _Category.all || _category == cat;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: _DashboardAppBar(),
      body: _buildBody(state),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 1,
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
        ],
        onTap: (i) {
          if (i == 0) {
            context.go('/');
          }
        },
      ),
    );
  }

  Widget _buildBody(DashboardState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.error!, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: () =>
                  ref.read(dashboardControllerProvider.notifier).loadDashboard(),
              child: const Text('再読み込み'),
            ),
          ],
        ),
      );
    }

    // カテゴリ別にインサイトを分類
    final valuesCategory = _findCategory(state.categories, 'values');
    final strengthsCategory = _findCategory(state.categories, 'strengths');
    final interestsCategory = _findCategory(state.categories, 'interests');

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(dashboardControllerProvider.notifier).loadDashboard(),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePadding,
          vertical: AppSpacing.lg,
        ),
        children: [
          InsightMetricRow(
            primaryLabel: 'カテゴリ数',
            primaryValue: '${state.categories.length}',
            primaryTrend: '',
            primaryTrendPositive: true,
            secondaryLabel: 'インサイト数',
            secondaryValue: '${state.totalCount}',
            secondaryTrend: '',
            secondaryTrendPositive: true,
          ),
          const SizedBox(height: AppSpacing.md),
          _CategoryFilterRow(
            selected: _category,
            onChanged: (c) => setState(() => _category = c),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_shouldShow(_Category.coreValues)) ...[
            _InsightListSection(
              title: valuesCategory?.displayName ?? '価値観 (Values)',
              icon: const Icon(Icons.favorite_border_rounded),
              insights: valuesCategory?.insights.toList() ?? [],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_shouldShow(_Category.strengths)) ...[
            _InsightListSection(
              title: strengthsCategory?.displayName ?? '強み (Strengths)',
              icon: const Icon(Icons.bolt_rounded),
              insights: strengthsCategory?.insights.toList() ?? [],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_shouldShow(_Category.interests)) ...[
            _InterestsSection(
              title: interestsCategory?.displayName ?? '興味 (Interests)',
              insights: interestsCategory?.insights.toList() ?? [],
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (_shouldShow(_Category.insights)) ...[
            _RecentInsightsSection(insights: state.recentInsights),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }

  DashboardCategory? _findCategory(
      List<DashboardCategory> categories, String key) {
    try {
      return categories.firstWhere((c) => c.categoryKey == key);
    } catch (_) {
      return null;
    }
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
// インサイト一覧セクション（価値観・強み共通）
// ---------------------------------------------------------------------------

class _InsightListSection extends StatelessWidget {
  const _InsightListSection({
    required this.title,
    required this.icon,
    required this.insights,
  });

  final String title;
  final Widget icon;
  final List<Insight> insights;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: title,
      icon: icon,
      child: insights.isEmpty
          ? _EmptyHint()
          : Column(
              children: [
                for (int i = 0; i < insights.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.sm),
                  _InsightContentCard(insight: insights[i]),
                ],
              ],
            ),
    );
  }
}

class _InsightContentCard extends StatelessWidget {
  const _InsightContentCard({required this.insight});

  final Insight insight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final date = insight.createdAt;
    final dateStr =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

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
          Text(insight.content, style: textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            dateStr,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 興味セクション（タグ表示）
// ---------------------------------------------------------------------------

class _InterestsSection extends StatelessWidget {
  const _InterestsSection({
    required this.title,
    required this.insights,
  });

  final String title;
  final List<Insight> insights;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DashboardCard.section(
      title: title,
      icon: const Icon(Icons.auto_awesome_rounded),
      child: insights.isEmpty
          ? _EmptyHint()
          : Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: insights.map((insight) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: colorScheme.primary.withOpacity(0.1)),
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
                      Flexible(
                        child: Text(insight.content,
                            style: textTheme.bodyMedium),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}

// ---------------------------------------------------------------------------
// 最新の気づきセクション
// ---------------------------------------------------------------------------

class _RecentInsightsSection extends StatelessWidget {
  const _RecentInsightsSection({required this.insights});

  final List<Insight> insights;

  @override
  Widget build(BuildContext context) {
    return DashboardCard.section(
      title: '最新の気づき (Insights)',
      icon: const Icon(Icons.lightbulb_outline_rounded),
      child: insights.isEmpty
          ? _EmptyHint()
          : Column(
              children: [
                for (int i = 0; i < insights.length; i++) ...[
                  if (i > 0) const SizedBox(height: AppSpacing.sm),
                  if (i == 0)
                    _FeaturedInsightCard(insight: insights[i])
                  else
                    _InsightContentCard(insight: insights[i]),
                ],
              ],
            ),
    );
  }
}

class _FeaturedInsightCard extends StatelessWidget {
  const _FeaturedInsightCard({required this.insight});

  final Insight insight;

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
                      insight.content,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Text(
                          insight.categoryDisplayName,
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
