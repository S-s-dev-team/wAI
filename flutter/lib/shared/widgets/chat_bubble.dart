import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';

enum ChatSender { ai, user }

/// チャット画面の発言バブル。
///
/// [sender] が [ChatSender.user] の場合は右寄せ・プライマリ背景、
/// [ChatSender.ai] の場合は左寄せ・サーフェス背景になる。
/// AI先輩の場合は [senderName] ラベルと [avatarUrl] アバターを表示する。
class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.sender,
    this.senderName,
    this.avatarUrl,
  });

  final String message;
  final ChatSender sender;
  final String? senderName;
  final String? avatarUrl;

  bool get _isUser => sender == ChatSender.user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final backgroundColor =
        _isUser ? colorScheme.primary : colorScheme.surface;
    final textColor =
        _isUser ? colorScheme.onPrimary : colorScheme.onSurface;

    final bubble = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _kMaxBubbleWidth),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: const [_kBubbleShadow],
        ),
        child: Text(
          message,
          style: textTheme.bodyMedium?.copyWith(color: textColor),
        ),
      ),
    );

    if (_isUser) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (senderName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                senderName!,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          bubble,
        ],
      );
    }

    // AI sender — avatar + name label
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (senderName != null)
          Padding(
            padding: const EdgeInsets.only(
              left: _kAvatarSize + AppSpacing.sm,
              bottom: AppSpacing.xs,
            ),
            child: Text(
              senderName!,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _SenderAvatar(avatarUrl: avatarUrl),
            const SizedBox(width: AppSpacing.sm),
            Flexible(child: bubble),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar
// ---------------------------------------------------------------------------

const double _kAvatarSize = 32.0;

class _SenderAvatar extends StatelessWidget {
  const _SenderAvatar({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CircleAvatar(
      radius: _kAvatarSize / 2,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child: avatarUrl == null
          ? Icon(
              Icons.person_rounded,
              color: colorScheme.primary,
              size: _kAvatarSize * 0.55,
            )
          : null,
    );
  }
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/// バブルの最大幅。画面幅の約75%相当の固定値。
const double _kMaxBubbleWidth = 286.0;

const BoxShadow _kBubbleShadow = BoxShadow(
  color: AppColors.shadowLight,
  blurRadius: 2,
  offset: Offset(0, 1),
);
