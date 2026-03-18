import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../constants/spacing.dart';
import '../../../constants/text_styles.dart';
import '../../../common_widgets/app_bottom_navigation.dart';
import '../../../common_widgets/app_primary_button.dart';
import 'create_mentor_controller.dart';
import 'create_mentor_form_section.dart';

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
  const _IncomeTier({required this.range, required this.label, required this.value});
  final String range;
  final String label;
  /// API に送る年収（万円）
  final int value;
}

const _incomeOptions = [
  _IncomeTier(range: '〜600万円', label: '中堅層', value: 500),
  _IncomeTier(range: '600〜1,000万円', label: 'ハイキャリア', value: 800),
  _IncomeTier(range: '1,000〜1,500万円', label: 'エグゼクティブ', value: 1200),
  _IncomeTier(range: '1,500万円〜', label: 'トップクラス', value: 1800),
];

/// 年齢ラベルを API に送る代表値（int）に変換する。
int _ageToInt(String label) {
  switch (label) {
    case '20代':
      return 25;
    case '30代':
      return 35;
    case '40代':
      return 45;
    case '50代':
      return 55;
    case '60代〜':
      return 65;
    case 'こだわらない':
      return 30;
    default:
      return 30;
  }
}

// ---------------------------------------------------------------------------
// Contents
// ---------------------------------------------------------------------------

/// 「理想の先輩を作る」フォームUI。
///
/// 性別・年齢・職種・年収を選択し、[onSubmit] で [CreateMentorInput] を返す。
class CreateMentorContents extends StatefulWidget {
  const CreateMentorContents({
    super.key,
    required this.onSubmit,
    this.onBack,
    this.isLoading = false,
  });

  final ValueChanged<CreateMentorInput> onSubmit;
  final VoidCallback? onBack;
  final bool isLoading;

  @override
  State<CreateMentorContents> createState() => _CreateMentorContentsState();
}

class _CreateMentorContentsState extends State<CreateMentorContents> {
  String? _gender;
  String? _age;
  String _occupation = _occupationOptions.first;
  int? _selectedIncomeIndex;

  bool get _canSubmit =>
      _gender != null &&
      _age != null &&
      _selectedIncomeIndex != null &&
      !widget.isLoading;

  void _handleSubmit() {
    if (!_canSubmit) return;
    widget.onSubmit(
      CreateMentorInput(
        gender: _gender!,
        age: _ageToInt(_age!),
        occupation: _occupation,
        annualIncome: _incomeOptions[_selectedIncomeIndex!].value,
      ),
    );
  }

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
            CreateMentorFormSection(
              label: '性別',
              icon: const Icon(Icons.wc_rounded),
              child: _GenderChips(
                options: _genderOptions,
                selected: _gender,
                onChanged: (v) => setState(() => _gender = v),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            CreateMentorFormSection(
              label: '年齢',
              icon: const Icon(Icons.calendar_today_rounded),
              child: _AgeChips(
                options: _ageOptions,
                selected: _age,
                onChanged: (v) => setState(() => _age = v),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            CreateMentorFormSection(
              label: '職種',
              icon: const Icon(Icons.work_outline_rounded),
              child: _OccupationDropdown(
                options: _occupationOptions,
                value: _occupation,
                onChanged: (v) => setState(() => _occupation = v ?? _occupation),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            CreateMentorFormSection(
              label: '年収',
              icon: const Icon(Icons.account_balance_wallet_outlined),
              child: _IncomeGrid(
                options: _incomeOptions,
                selectedIndex: _selectedIncomeIndex,
                onChanged: (i) => setState(() => _selectedIncomeIndex = i),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppPrimaryButton(
              label: 'この先輩と話す',
              onPressed: _canSubmit ? _handleSubmit : null,
              leading: widget.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.surface,
                      ),
                    )
                  : const Icon(Icons.chat_rounded, size: 20),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
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
        onTap: (_) {},
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
      initialValue: value,
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
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<_IncomeTier> options;
  final int? selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _IncomeCard(
                tier: options[0],
                selected: selectedIndex == 0,
                onTap: () => onChanged(0),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _IncomeCard(
                tier: options[1],
                selected: selectedIndex == 1,
                onTap: () => onChanged(1),
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
                selected: selectedIndex == 2,
                onTap: () => onChanged(2),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _IncomeCard(
                tier: options[3],
                selected: selectedIndex == 3,
                onTap: () => onChanged(3),
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
