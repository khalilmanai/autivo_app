import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../common_view.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _newEmailController = TextEditingController();
  final _currentPasswordForEmailController = TextEditingController();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isChangingEmail = false;
  bool _isChangingPassword = false;

  @override
  void dispose() {
    _newEmailController.dispose();
    _currentPasswordForEmailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final userVM = context.watch<UserViewModel>();
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(t.profile.security),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              context,
              t.profile.changeEmail,
              'Update your email address',
              [
                Form(
                  key: _emailFormKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _newEmailController,
                        label: t.profile.newEmail,
                        hint: 'new@email.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.email,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const Gap(20),
                      AppPasswordField(
                        controller: _currentPasswordForEmailController,
                        label: t.auth.currentPassword,
                        hint: '••••••••',
                        textInputAction: TextInputAction.done,
                        validator: (v) => Validators.required(
                          v,
                          fieldName: t.auth.currentPassword,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: AppButton(
                    onPressed:
                        _isChangingEmail ||
                            (userVM.isLoading || authVM.isLoading)
                        ? null
                        : _changeEmail,
                    isLoading:
                        _isChangingEmail ||
                        userVM.isLoading ||
                        authVM.isLoading,
                    child: Text(
                      t.common.save,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                ErrorFeedback(error: userVM.error),
              ],
            ),
            const Gap(32),
            _buildSection(
              context,
              t.profile.changePassword,
              'Update your password securely',
              [
                Form(
                  key: _passwordFormKey,
                  child: Column(
                    children: [
                      AppPasswordField(
                        controller: _currentPasswordController,
                        label: t.auth.currentPassword,
                        hint: '••••••••',
                        textInputAction: TextInputAction.next,
                        validator: (v) => Validators.required(
                          v,
                          fieldName: t.auth.currentPassword,
                        ),
                      ),
                      const Gap(20),
                      AppPasswordField(
                        controller: _newPasswordController,
                        label: t.auth.newPassword,
                        hint: '••••••••',
                        textInputAction: TextInputAction.next,
                        validator: Validators.password,
                      ),
                      const Gap(20),
                      AppPasswordField(
                        controller: _confirmPasswordController,
                        label: t.auth.confirmPassword,
                        hint: '••••••••',
                        textInputAction: TextInputAction.done,
                        validator: (v) => Validators.confirmPassword(
                          v,
                          _newPasswordController.text,
                        ),
                        onSubmitted: (_) => _changePassword(),
                      ),
                    ],
                  ),
                ),
                const Gap(24),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: AppButton(
                    onPressed:
                        _isChangingPassword ||
                            (userVM.isLoading || authVM.isLoading)
                        ? null
                        : _changePassword,
                    isLoading:
                        _isChangingPassword ||
                        userVM.isLoading ||
                        authVM.isLoading,
                    child: Text(
                      t.profile.changePassword,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                ErrorFeedback(error: userVM.error),
              ],
            ),
            const Gap(32),
            _buildSection(
              context,
              'Active Sessions',
              'Manage your currently logged in devices',
              [
                AppCard(
                  padding: const EdgeInsets.all(16),
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.devices_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      const Gap(16),
                      Expanded(
                        child: Text(
                          'Session management coming soon',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String subtitle,
    List<Widget> children,
  ) {
    final theme = Theme.of(context);
    return EntranceFadeSlide(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Gap(4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Gap(20),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _changeEmail() async {
    if (!_emailFormKey.currentState!.validate()) return;

    setState(() => _isChangingEmail = true);

    final success = await context.read<UserViewModel>().changeEmail(
      newEmail: _newEmailController.text.trim(),
      currentPassword: _currentPasswordForEmailController.text,
    );

    // Guarded: the user can leave this screen while the request is in flight.
    if (!mounted) return;
    setState(() => _isChangingEmail = false);

    if (success) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.t.profile.emailChanged),
            behavior: SnackBarBehavior.floating,
          ),
        );
      _newEmailController.clear();
      _currentPasswordForEmailController.clear();
    } else {
      _showError(context.read<UserViewModel>().error?.message);
    }
  }

  Future<void> _changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;

    setState(() => _isChangingPassword = true);

    final success = await context.read<UserViewModel>().changePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    );

    if (!mounted) return;
    setState(() => _isChangingPassword = false);

    if (success) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.t.profile.passwordChanged),
            behavior: SnackBarBehavior.floating,
          ),
        );
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      // No `context.go('/login')` here: the auth redirect in `app_routes.dart`
      // bounces an authenticated user straight back out of `/login`, making the
      // navigation a silent no-op that discarded the success feedback.
    } else {
      _showError(context.read<UserViewModel>().error?.message);
    }
  }

  void _showError(String? message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message ?? context.t.common.error),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
