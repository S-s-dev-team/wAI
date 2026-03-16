import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import 'chat_action_menu.dart';

/// チャット画面下部の入力バー。
///
/// テキストフィールドと送信ボタンで構成される。
/// 送信ボタンは [controller] にテキストがある場合のみ有効になる。
/// 「+」ボタンで [ChatActionMenu] を表示する。
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.onSend,
    this.hintText = 'メッセージを入力...',
    this.controller,
    this.onAddSenior,
    this.onUpdateAnalysis,
  });

  final ValueChanged<String> onSend;
  final String hintText;

  /// 外部から渡す場合のコントローラー。省略時は内部で管理する。
  final TextEditingController? controller;

  /// 「先輩を追加する」タップ時コールバック。
  final VoidCallback? onAddSenior;

  /// 「自己分析を更新」タップ時コールバック。
  final VoidCallback? onUpdateAnalysis;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  final LayerLink _plusLayerLink = LayerLink();
  OverlayEntry? _popupEntry;

  void _togglePopup() {
    if (_popupEntry != null) {
      _popupEntry!.remove();
      _popupEntry = null;
      return;
    }
    _popupEntry = ChatActionMenu.show(
      context: context,
      layerLink: _plusLayerLink,
      onAddSenior: () {
        _popupEntry = null;
        widget.onAddSenior?.call();
      },
      onUpdateAnalysis: () {
        _popupEntry = null;
        widget.onUpdateAnalysis?.call();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _popupEntry?.remove();
    _popupEntry = null;
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: const Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CompositedTransformTarget(
                link: _plusLayerLink,
                child: _PlusButton(onTap: _togglePopup),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleSend(),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    filled: true,
                    fillColor: AppColors.base,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusPill),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: AppColors.textTertiary,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _SendButton(
                enabled: _hasText,
                onTap: _handleSend,
                color: colorScheme.primary,
                iconColor: colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlusButton extends StatelessWidget {
  const _PlusButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.add,
          size: 24,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.enabled,
    required this.onTap,
    required this.color,
    required this.iconColor,
  });

  final bool enabled;
  final VoidCallback onTap;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: enabled ? 1.0 : 0.4,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.send_rounded,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
