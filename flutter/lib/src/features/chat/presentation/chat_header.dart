import 'package:flutter/material.dart';
import '../../../constants/spacing.dart';

/// チャット画面のヘッダー（AppBar として使用）。
///
/// タイトル・戻るボタン・アバターで構成される。
/// [PreferredSizeWidget] を実装しているため [Scaffold.appBar] に直接渡せる。
class ChatHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChatHeader({
    super.key,
    required this.title,
    this.avatarUrl,
    this.onBack,
    this.onAvatarTap,
  });

  final String title;
  final String? avatarUrl;
  final VoidCallback? onBack;
  final VoidCallback? onAvatarTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      leading: onBack != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: onBack,
            )
          : null,
      centerTitle: true,
      title: Text(title, style: textTheme.titleMedium),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: GestureDetector(
            onTap: onAvatarTap,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.primaryContainer,
              backgroundImage:
                  avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: avatarUrl == null
                  ? Icon(
                      Icons.person_rounded,
                      color: colorScheme.primary,
                      size: 22,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
