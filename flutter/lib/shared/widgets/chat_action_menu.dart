import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';

/// ChatInputBar の「+」ボタンに紐づくフローティングアクションメニュー。
///
/// [ChatActionMenu.show] で表示、タップアウト or アイテム選択で閉じる。
class ChatActionMenu extends StatelessWidget {
  const ChatActionMenu({
    super.key,
    required this.onAddSenior,
    required this.onUpdateAnalysis,
    required this.onDismiss,
  });

  final VoidCallback onAddSenior;
  final VoidCallback onUpdateAnalysis;
  final VoidCallback onDismiss;

  /// [layerLink] に `CompositedTransformTarget` を貼った「+」ボタンの
  /// 真上にメニューを表示し、OverlayEntry を返す。
  static OverlayEntry show({
    required BuildContext context,
    required LayerLink layerLink,
    required VoidCallback onAddSenior,
    required VoidCallback onUpdateAnalysis,
  }) {
    late OverlayEntry entry;

    void dismiss() {
      entry.remove();
    }

    entry = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: dismiss,
        child: SizedBox.expand(
          child: Stack(
            children: [
              CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.topLeft,
                followerAnchor: Alignment.bottomLeft,
                offset: const Offset(0, -8),
                child: GestureDetector(
                  // メニュー自体のタップが dismiss に伝播しないよう吸収
                  onTap: () {},
                  child: Material(
                    type: MaterialType.transparency,
                    child: ChatActionMenu(
                      onAddSenior: () {
                        dismiss();
                        onAddSenior();
                      },
                      onUpdateAnalysis: () {
                        dismiss();
                        onUpdateAnalysis();
                      },
                      onDismiss: dismiss,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    return entry;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 208,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 25,
            offset: Offset(0, 20),
            spreadRadius: -5,
          ),
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 10,
            offset: Offset(0, 8),
            spreadRadius: -6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuItem(
              icon: Icons.person_add_alt_1_rounded,
              label: '先輩を追加する',
              onTap: onAddSenior,
              showDivider: true,
            ),
            _MenuItem(
              icon: Icons.psychology_outlined,
              label: '自己分析を更新',
              onTap: onUpdateAnalysis,
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.showDivider,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: colorScheme.onSurface),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (showDivider)
            const Divider(height: 1, color: AppColors.border),
        ],
      ),
    );
  }
}
