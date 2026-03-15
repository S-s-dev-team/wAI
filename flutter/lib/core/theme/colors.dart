import 'package:flutter/material.dart';

abstract final class AppColors {
  /// ベースカラー（背景）
  static const Color base = Color(0xFFF7F7F8);

  /// サーフェス（カード・シート）
  static const Color surface = Color(0xFFFFFFFF);

  /// ボーダー
  static const Color border = Color(0xFFE5E7EB);

  /// テキスト：プライマリ
  static const Color textPrimary = Color(0xFF111827);

  /// テキスト：セカンダリ
  static const Color textSecondary = Color(0xFF6B7280);

  /// テキスト：ターシャリ（タイムスタンプ・補足情報）
  static const Color textTertiary = Color(0xFF9CA3AF);

  /// アクセントカラー
  static const Color accent = Color(0xFF7C6EE6);

  /// アクセントカラー（ライト）
  static const Color accentLight = Color(0xFFEEEAFE);

  /// 成功・ポジティブ色
  static const Color success = Color(0xFF16A34A);

  /// シャドウ色（5%）
  static const Color shadowLight = Color(0x0D000000);

  /// シャドウ色（10%）
  static const Color shadowMedium = Color(0x1A000000);

  /// ダークオーバーレイ色（40%）
  static const Color overlayDark = Color(0x660F172A);

  /// シャドウ色（25%）
  static const Color shadowDark = Color(0x40000000);
}