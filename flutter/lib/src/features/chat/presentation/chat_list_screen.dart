import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wai_api/wai_api.dart';

import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../common_widgets/app_bottom_navigation.dart';
import 'chat_list_controller.dart';

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatListControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.base,
      appBar: const _ChatListAppBar(),
      body: _buildBody(context, ref, state),
      floatingActionButton: _NewChatFab(
        onTap: () => context.push('/create-mentor'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 0,
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
          if (i == 1) {
            context.push('/dashboard');
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, ChatListState state) {
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
                  ref.read(chatListControllerProvider.notifier).loadChats(),
              child: const Text('再読み込み'),
            ),
          ],
        ),
      );
    }

    if (state.chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'まだチャットがありません',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '「新しい相談を始める」から先輩を作成しましょう',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(chatListControllerProvider.notifier).loadChats(),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pagePadding,
          vertical: AppSpacing.sm,
        ),
        itemCount: state.chats.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final chat = state.chats[index];
          return _ChatListTile(
            chat: chat,
            onTap: () => context.push('/chat/${chat.id}'),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------

class _ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ChatListAppBar();

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
// Chat list tile
// ---------------------------------------------------------------------------

const double _kAvatarDiameter = 56.0;

class _ChatListTile extends StatelessWidget {
  const _ChatListTile({required this.chat, required this.onTap});

  final Chat chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final name = chat.persona.name;
    final role = chat.persona.occupation ?? '';
    final preview = chat.lastMessage ?? '';
    final date = chat.updatedAt;
    final timestamp =
        '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

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
              CircleAvatar(
                radius: _kAvatarDiameter / 2,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  Icons.person_rounded,
                  size: _kAvatarDiameter * 0.5,
                  color: colorScheme.primary,
                ),
              ),
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
                                  text: name,
                                  style: textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                if (role.isNotEmpty)
                                  TextSpan(
                                    text: '  ($role)',
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
                          timestamp,
                          style: textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      preview,
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
