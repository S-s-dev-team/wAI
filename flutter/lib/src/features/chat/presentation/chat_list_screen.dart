import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../common_widgets/app_bottom_navigation.dart';
import '../../../common_widgets/app_chip.dart';
import '../../senior/presentation/create_senior_screen.dart';
import '../../dashboard/presentation/dashboard_screen.dart';

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

class ChatListItem {
  const ChatListItem({
    required this.id,
    required this.name,
    required this.role,
    required this.preview,
    required this.timestamp,
    this.avatarUrl,
    this.hasUnread = false,
    this.isOnline = false,
  });

  final String id;
  final String name;
  final String role;
  final String preview;
  final String timestamp;
  final String? avatarUrl;
  final bool hasUnread;
  final bool isOnline;
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// チャット一覧画面。
///
/// - AppBar: タイトル + 検索 + アバター
/// - カテゴリチップ（横スクロール）
/// - チャット行リスト
/// - 「新しい相談を始める」FAB（中央下）
/// - BottomNavigation
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({
    super.key,
    this.items = const [],
    this.categories = const ['すべて', 'IT・通信', 'マーケティング', '未読'],
    this.onItemTap,
    this.onNewChat,
    this.onSearch,
    this.onNavTap,
    this.currentNavIndex = 0,
  });

  final List<ChatListItem> items;
  final List<String> categories;
  final ValueChanged<String>? onItemTap;
  final VoidCallback? onNewChat;
  final VoidCallback? onSearch;
  final ValueChanged<int>? onNavTap;
  final int currentNavIndex;

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: _ChatListAppBar(onSearch: widget.onSearch),
      body: Column(
        children: [
          _CategoryRow(
            categories: widget.categories,
            selectedIndex: _selectedCategory,
            onSelected: (i) => setState(() => _selectedCategory = i),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
                vertical: AppSpacing.sm,
              ),
              itemCount: widget.items.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return _ChatListTile(
                  item: item,
                  onTap: () => widget.onItemTap?.call(item.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _NewChatFab(
        onTap: widget.onNewChat ?? () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateSeniorScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        onTap: (i) {
          widget.onNavTap?.call(i);
          if (i == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const DashboardScreen(
                  analysisCount: '12',
                  analysisTrend: '+3',
                  analysisTrendPositive: true,
                  insightCount: '34',
                  insightTrend: '+8',
                  insightTrendPositive: true,
                  coreValue: CoreValueData(
                    badge: '✨',
                    timestamp: '2024-03-15',
                    title: '成長志向',
                    description: '常に学び続けることを大切にしている',
                  ),
                  strengths: [
                    StrengthData(
                      icon: Icons.lightbulb_outline_rounded,
                      name: '問題解決力',
                      description: '複雑な課題を分解して解決できる',
                    ),
                    StrengthData(
                      icon: Icons.people_outline_rounded,
                      name: 'コミュニケーション力',
                      description: '多様な立場の人と円滑に協力できる',
                    ),
                  ],
                  interests: ['IT・通信', 'マーケティング', 'コンサルティング'],
                  insightQuotes: [
                    InsightQuoteData(
                      text: 'チームで協力することにやりがいを感じる',
                      label: 'チームワーク',
                      isFeatured: true,
                    ),
                    InsightQuoteData(
                      text: '新しい技術を習得することが好き',
                      label: '学習意欲',
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------

class _ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ChatListAppBar({this.onSearch});

  final VoidCallback? onSearch;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      centerTitle: true,
      title: Text('チャット一覧', style: textTheme.titleMedium),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: onSearch,
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(
              Icons.person_rounded,
              color: colorScheme.primary,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Category chips row
// ---------------------------------------------------------------------------

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePadding,
          vertical: AppSpacing.lg,
        ),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm + 4),
        itemBuilder: (context, index) => AppChip(
          label: categories[index],
          selected: selectedIndex == index,
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Chat list tile
// ---------------------------------------------------------------------------

const double _kAvatarDiameter = 56.0;

class _ChatListTile extends StatelessWidget {
  const _ChatListTile({required this.item, required this.onTap});

  final ChatListItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Avatar(avatarUrl: item.avatarUrl, isOnline: item.isOnline),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: item.name,
                                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: '  (${item.role})',
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          item.timestamp,
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.preview,
                            style: textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (item.hasUnread) ...[
                          const SizedBox(width: AppSpacing.sm),
                          _UnreadDot(),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar with optional online indicator
// ---------------------------------------------------------------------------

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl, required this.isOnline});

  final String? avatarUrl;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: _kAvatarDiameter / 2,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage:
              avatarUrl != null ? NetworkImage(avatarUrl!) : null,
          child: avatarUrl == null
              ? Icon(
                  Icons.person_rounded,
                  size: _kAvatarDiameter * 0.5,
                  color: colorScheme.primary,
                )
              : null,
        ),
        if (isOnline)
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _kOnlineColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surface,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Unread dot
// ---------------------------------------------------------------------------

class _UnreadDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// New chat FAB
// ---------------------------------------------------------------------------

class _NewChatFab extends StatelessWidget {
  const _NewChatFab({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return FloatingActionButton.extended(
      onPressed: onTap,
      elevation: 2,
      backgroundColor: colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      icon: Icon(
        Icons.add_comment_rounded,
        color: colorScheme.onPrimary,
        size: 20,
      ),
      label: Text(
        '新しい相談を始める',
        style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/// オンラインインジケーターの色。
const Color _kOnlineColor = AppColors.success;
