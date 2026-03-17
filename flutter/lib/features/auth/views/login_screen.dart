import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/text_styles.dart';

/// ログイン画面。
///
/// - AppBar・BottomNavigation なし
/// - Googleログイン / サインアップリンク
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    this.onGoogleLogin,
    this.onSignUp,
    this.isLoading = false,
  });

  final VoidCallback? onGoogleLogin;
  final VoidCallback? onSignUp;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.base,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 86,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _AppLogo(),
                    const SizedBox(height: AppSpacing.xl),
                    const _HeroImage(),
                    const SizedBox(height: AppSpacing.xl),
                    _GoogleLoginButton(
                      onPressed: onGoogleLogin,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const _EmpoweredBanner(),
                  ],
                ),
              ),
            ),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App Logo
// ---------------------------------------------------------------------------

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: AppColors.accentLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          child: const Icon(
            Icons.school_rounded,
            size: 40,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'AI先輩',
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            height: 1.1,
            letterSpacing: -0.9,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Find your career path with AI mentors',
          style: AppTextStyles.h3.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Hero Image
// ---------------------------------------------------------------------------

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.1),
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: AspectRatio(
          aspectRatio: 358 / 200,
          child: Container(
            color: AppColors.accentLight,
            child: Icon(
              Icons.people_alt_rounded,
              size: 64,
              color: AppColors.accent.withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Google Login Button
// ---------------------------------------------------------------------------

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({this.onPressed, this.isLoading = false});

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.accent.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.surface,
                  ),
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LoginIcon(),
                    SizedBox(width: AppSpacing.sm + AppSpacing.xs),
                    Text('Continue with Google'),
                  ],
                ),
        ),
      ),
    );
  }
}

class _LoginIcon extends StatelessWidget {
  const _LoginIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.login_rounded,
      size: 18,
      color: AppColors.surface,
    );
  }
}

// ---------------------------------------------------------------------------
// Sign Up Link
// ---------------------------------------------------------------------------

class _SignUpRow extends StatelessWidget {
  const _SignUpRow({this.onSignUp});

  final VoidCallback? onSignUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New to AI先輩? ',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: onSignUp,
          child: Text(
            'Sign up',
            style: AppTextStyles.body.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Empowered Banner
// ---------------------------------------------------------------------------

class _EmpoweredBanner extends StatelessWidget {
  const _EmpoweredBanner();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 1,
            color: const Color(0xFFCBD5E1),
          ),
          const SizedBox(width: AppSpacing.lg),
          Text(
            'EMPOWERED BY AI',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Container(
            width: 48,
            height: 1,
            color: const Color(0xFFCBD5E1),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Text(
        '© ${DateTime.now().year} AI先輩. All rights reserved.',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textTertiary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
