import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../common_view.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({required this.token, super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => context.push('/login'),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: CurvedBackground(
        enableAnimation: false,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: EntranceFadeSlide(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(24),
                    Hero(
                      tag: 'app_logo',
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withValues(
                                  alpha: 0.15,
                                ),
                                theme.colorScheme.secondary.withValues(
                                  alpha: 0.05,
                                ),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.05,
                                ),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.lock_open_rounded,
                            size: 64,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const Gap(32),
                    Text(
                      t.auth.resetPasswordTitle,
                      style: theme.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(12),
                    Text(
                      t.auth.resetPasswordSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(48),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppPasswordField(
                            controller: _passwordController,
                            label: t.auth.newPassword,
                            hint: '••••••••',
                            textInputAction: TextInputAction.next,
                            validator: Validators.password,
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            autofillHints: const [AutofillHints.newPassword],
                          ),
                          const Gap(20),
                          AppPasswordField(
                            controller: _confirmPasswordController,
                            label: t.auth.confirmPassword,
                            hint: '••••••••',
                            textInputAction: TextInputAction.done,
                            validator: (v) => Validators.confirmPassword(
                              v,
                              _passwordController.text,
                            ),
                            prefixIcon: const Icon(Icons.lock_reset_rounded),
                          ),
                          const Gap(32),
                          SizedBox(
                            height: 56,
                            child: AppButton(
                              onPressed: authVM.isLoading ? null : _submit,
                              isLoading: authVM.isLoading,
                              child: Text(
                                t.auth.resetPassword,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          ErrorFeedback(error: authVM.error),
                        ],
                      ),
                    ),
                    const Gap(24),
                    TextButton(
                      onPressed: () => context.push('/login'),
                      child: Text(
                        t.common.back,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final t = context.t;
    final success = await context.read<AuthViewModel>().resetPassword(
      token: widget.token,
      password: _passwordController.text,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.profile.passwordChanged),
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.go('/login');
    }
  }
}
