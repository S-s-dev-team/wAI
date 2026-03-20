import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../common_widgets/app_primary_button.dart';
import '../../../common_widgets/mentor_option_card.dart';

// ---------------------------------------------------------------------------
// Preset mentor data
// ---------------------------------------------------------------------------

enum _MentorPreset {
  passion('yarigai'),
  income('nenshu');

  const _MentorPreset(this.presetKey);

  /// API に送信する preset_key 値。
  final String presetKey;
}

class _MentorDef {
  const _MentorDef({
    required this.preset,
    required this.icon,
    required this.title,
    required this.description,
  });

  final _MentorPreset preset;
  final IconData icon;
  final String title;
  final String description;
}

const _kPresets = [
  _MentorDef(
    preset: _MentorPreset.passion,
    icon: Icons.favorite_border_rounded,
    title: 'やりがい重視先輩',
    description: '仕事の意義や自己成長、社会貢献を大切にする視点からアドバイスを伝えます。',
  ),
  _MentorDef(
    preset: _MentorPreset.income,
    icon: Icons.trending_up_rounded,
    title: '年収重視先輩',
    description: 'キャリアアップ、市場価値、報酬の最大化を狙う戦略的なアドバイスを伝えます。',
  ),
];

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/// チャット画面からオーバーレイ表示するメンター追加シート。
///
/// [showAddSeniorOverlay] で起動する。バックドロップのブラー＋暗転つき。
/// 選択確定時に [onConfirm] へ選択された [_MentorPreset] が渡される。
Future<void> showAddSeniorOverlay({
  required BuildContext context,
  required ValueChanged<String> onConfirm,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'AddSeniorOverlay',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 280),
    transitionBuilder: (ctx, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.15),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
    pageBuilder: (ctx, animation, _) => _AddSeniorOverlayPage(
      onConfirm: (preset) {
        Navigator.of(ctx).pop();
        onConfirm(preset.presetKey);
      },
    ),
  );
}

// ---------------------------------------------------------------------------
// Page wrapper (backdrop + sheet)
// ---------------------------------------------------------------------------

class _AddSeniorOverlayPage extends StatelessWidget {
  const _AddSeniorOverlayPage({required this.onConfirm});

  final ValueChanged<_MentorPreset> onConfirm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Stack(
        children: [
          // Blurred + darkened backdrop
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: AppColors.overlayDark,
            ),
          ),
          // Bottom sheet anchored to bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              // absorb taps so they don't propagate to the dismiss detector
              onTap: () {},
              child: _AddSeniorSheet(onConfirm: onConfirm),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sheet content
// ---------------------------------------------------------------------------

class _AddSeniorSheet extends StatefulWidget {
  const _AddSeniorSheet({required this.onConfirm});

  final ValueChanged<_MentorPreset> onConfirm;

  @override
  State<_AddSeniorSheet> createState() => _AddSeniorSheetState();
}

class _AddSeniorSheetState extends State<_AddSeniorSheet> {
  _MentorPreset? _selected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.base,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusBottomSheet),
        ),
        border: Border(
          top: BorderSide(color: colorScheme.primary.withOpacity(0.1)),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 50,
            offset: Offset(0, 25),
            spreadRadius: -12,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              _Handle(),
              // Header row
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.md,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '先輩を追加する',
                        style: textTheme.titleLarge?.copyWith(
                          letterSpacing: -0.55,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        color: colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                  ],
                ),
              ),
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Text(
                  'チャットに参加させるAI先輩を選択してください。',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              // Option cards
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < _kPresets.length; i++) ...[
                      if (i > 0) const SizedBox(height: AppSpacing.md),
                      MentorOptionCard(
                        icon: Icon(_kPresets[i].icon),
                        title: _kPresets[i].title,
                        description: _kPresets[i].description,
                        selected: _selected == _kPresets[i].preset,
                        onTap: () => setState(
                          () => _selected = _kPresets[i].preset,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // CTA button
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.xl,
                ),
                child: AppPrimaryButton(
                  label: '先輩を追加してチャットを始める',
                  onPressed: _selected != null
                      ? () => widget.onConfirm(_selected!)
                      : null,
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
// Handle bar
// ---------------------------------------------------------------------------

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 32,
      width: double.infinity,
      child: Center(
        child: Container(
          width: 48,
          height: 6,
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          ),
        ),
      ),
    );
  }
}
