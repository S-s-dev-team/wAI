import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../constants/text_styles.dart';
import '../../../common_widgets/app_bottom_navigation.dart';
import '../../../common_widgets/app_primary_button.dart';
import '../../mentor/presentation/mentor_form_section.dart';

// ---------------------------------------------------------------------------
// Data
// ---------------------------------------------------------------------------

const _genderOptions = ['男性', '女性', '指定なし'];

const _ageOptions = ['20代', '30代', '40代', '50代', '60代〜', 'こだわらない'];

const _occupationOptions = [
  'エンジニア',
  'マーケティング',
  '営業',
  'デザイナー',
  '経営企画',
  '人事・採用',
  'コンサルタント',
  'クリエイティブ',
];

class _IncomeTier {
  const _IncomeTier({required this.range, required this.label});
  final String range;
  final String label;
}

const _incomeOptions = [
  _IncomeTier(range: '〜600万円', label: '中堅層'),
  _IncomeTier(range: '600〜1,000万円', label: 'ハイキャリア'),
  _IncomeTier(range: '1,000〜1,500万円', label: 'エグゼクティブ'),
  _IncomeTier(range: '1,500万円〜', label: 'トップクラス'),
];

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

/// AI先輩作成画面（「理想の先輩を作る」）。
///
/// 性別・年齢・職種・年収を選択し、[onConfirm] でフォーム値を返す。
class CreateSeniorScreen extends StatefulWidget {
  const CreateSeniorScreen({
    super.key,
    this.onBack,
    this.onConfirm,
    this.onNavTap,
    this.currentNavIndex = 0,
  });

  final VoidCallback? onBack;
  final VoidCallback? onConfirm;
  final ValueChanged<int>? onNavTap;
  final int currentNavIndex;

  @override
  State<CreateSeniorScreen> createState() => _CreateSeniorScreenState();
}

class _CreateSeniorScreenState extends State<CreateSeniorScreen> {
  String? _gender;
  String? _age;
  String _occupation = _occupationOptions.first;
  String? _income;

  bool get _canSubmit =>
      _gender != null && _age != null && _income != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _AvatarHero(),
            const SizedBox(height: AppSpacing.xl),
            MentorFormSection(
              label: '性別',
              icon: const Icon(Icons.wc_rounded),
              child: _GenderChips(
                options: _genderOptions,
                selected: _gender,
                onChanged: (v) => setState(() => _gender = v),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            MentorFormSection(
              label: '年齢',
              icon: const Icon(Icons.calendar_today_rounded),
              child: _AgeChips(
                options: _ageOptions,
                selected: _age,
                onChanged: (v) => setState(() => _age = v),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            MentorFormSection(
              label: '職種',
              icon: const Icon(Icons.work_outline_rounded),
              child: _OccupationDropdown(
                options: _occupationOptions,
                value: _occupation,
                onChanged: (v) => setState(() => _occupation = v ?? _occupation),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            MentorFormSection(
              label: '年収',
              icon: const Icon(Icons.account_balance_wallet_outlined),
              child: _IncomeGrid(
                options: _incomeOptions,
                selected: _income,
                onChanged: (v) => setState(() => _income = v),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppPrimaryButton(
              label: 'この先輩と話す',
              onPressed: _canSubmit ? widget.onConfirm : null,
              leading: const Icon(Icons.chat_rounded, size: 20),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
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
        onTap: (i) => widget.onNavTap?.call(i),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: widget.onBack ?? () => Navigator.maybePop(context),
      ),
      centerTitle: true,
      title: Text('理想の先輩を作る', style: textTheme.titleMedium),
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar hero card
// ---------------------------------------------------------------------------

class _AvatarHero extends StatelessWidget {
  const _AvatarHero();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: colorScheme.primary,
                child: Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: colorScheme.onPrimary,
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.primaryContainer,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: 12,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'あなたの理想のメンターを定義しましょう',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Gender chips – 3 equal-width outlined toggle cells
// ---------------------------------------------------------------------------

class _GenderChips extends StatelessWidget {
  const _GenderChips({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _OutlineSelectChip(
              label: options[i],
              selected: selected == options[i],
              onTap: () => onChanged(options[i]),
            ),
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Age chips – Wrap layout
// ---------------------------------------------------------------------------

class _AgeChips extends StatelessWidget {
  const _AgeChips({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: options
          .map(
            (opt) => _OutlineSelectChip(
              label: opt,
              selected: selected == opt,
              onTap: () => onChanged(opt),
            ),
          )
          .toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared outlined selectable chip
// ---------------------------------------------------------------------------

class _OutlineSelectChip extends StatelessWidget {
  const _OutlineSelectChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outline,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: textTheme.labelLarge?.copyWith(
            color: selected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Occupation dropdown
// ---------------------------------------------------------------------------

class _OccupationDropdown extends StatelessWidget {
  const _OccupationDropdown({
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final List<String> options;
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      style: textTheme.bodyMedium,
      onChanged: onChanged,
      items: options
          .map(
            (opt) => DropdownMenuItem(
              value: opt,
              child: Text(opt),
            ),
          )
          .toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// Income grid – 2 × 2
// ---------------------------------------------------------------------------

class _IncomeGrid extends StatelessWidget {
  const _IncomeGrid({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<_IncomeTier> options;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    // 4 items → 2 rows × 2 columns
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _IncomeCard(
                tier: options[0],
                selected: selected == options[0].label,
                onTap: () => onChanged(options[0].label),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _IncomeCard(
                tier: options[1],
                selected: selected == options[1].label,
                onTap: () => onChanged(options[1].label),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _IncomeCard(
                tier: options[2],
                selected: selected == options[2].label,
                onTap: () => onChanged(options[2].label),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _IncomeCard(
                tier: options[3],
                selected: selected == options[3].label,
                onTap: () => onChanged(options[3].label),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _IncomeCard extends StatelessWidget {
  const _IncomeCard({
    required this.tier,
    required this.selected,
    required this.onTap,
  });

  final _IncomeTier tier;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outline,
            width: selected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tier.range,
              style: AppTextStyles.caption.copyWith(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              tier.label,
              style: textTheme.labelLarge?.copyWith(
                color: selected ? colorScheme.primary : colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
