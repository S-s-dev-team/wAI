import 'package:flutter/material.dart';
import '../constants/spacing.dart';

/// フルワイド・Pill形状のプライマリCTAボタン。
///
/// スタイルは [AppTheme] の [ElevatedButtonThemeData] に委譲する。
/// [leading] を渡すとアイコン付きボタン（例: Continue with Google）になる。
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
  });

  final String label;
  final VoidCallback? onPressed;

  /// ボタン左側に表示するウィジェット（アイコンなど）。
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: leading != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  leading!,
                  const SizedBox(width: AppSpacing.sm),
                  Text(label),
                ],
              )
            : Text(label),
      ),
    );
  }
}
