# Front-end Design System

This project uses a strict Flutter design system.

## Source of truth

Use the Flutter design system under:

- lib/core/theme/colors.dart
- lib/core/theme/spacing.dart
- lib/core/theme/text_styles.dart
- lib/core/theme/theme.dart

Do not blindly match raw Figma values if they conflict with the Flutter theme.
The Flutter theme is the source of truth.
Use Figma mainly for:

- layout
- hierarchy
- composition
- screen structure

## Typography

- Use Inter as the single font family across the app
- Do not introduce mixed font families
- Prefer Theme.of(context).textTheme
- AppTextStyles is the typography source of truth

## Color rules

Use AppColors only.
Do not hardcode Color(...) values in screens or widgets.

Important tokens include:

- base
- surface
- border
- textPrimary
- textSecondary
- textTertiary
- accent
- accentLight

## Spacing rules

Use AppSpacing only.
Do not hardcode padding, margin, radius, or sizes unless absolutely necessary.

Important spacing/radius tokens include:

- xs
- sm
- md
- lg
- xl
- xxl
- pagePadding
- radiusSm
- radiusMd
- radiusLg
- radiusXl
- radiusBottomSheet
- radiusPill

## Component philosophy

Prefer:

- reusable widgets
- token-based styling
- consistent spacing
- low visual noise
- border over heavy shadow

Avoid:

- arbitrary inline styles
- duplicated UI patterns
- random spacing values
- random font sizes
- overuse of accent color

## Accent usage

Accent color should be used sparingly.
Use accent mainly for:

- primary CTA
- active state
- selected state
- key highlights

Inactive states should remain neutral.

## Chat UI rules

- Chat screen is a focused screen
- Bottom navigation must be hidden on chat screen
- User messages and AI messages should be visually distinct
- Input bar stays fixed to the bottom
- The + action opens a popup, not a bottom sheet

## Navigation rules

Bottom navigation should have:

- メッセージ
- ダッシュボード
- 設定

Bottom navigation is visible on:

- chat list
- create senior
- dashboard
- settings

Bottom navigation is hidden on:

- chat screen
- login screen
