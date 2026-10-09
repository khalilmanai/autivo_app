import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/locale_controller.dart';
import '../../../data/models/user.dart' show UserPreferences;
import '../../viewmodels/auth_viewmodel.dart';
import '../common_view.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedLanguage = 'en';
  String _selectedDistanceUnit = 'km';
  String _selectedCurrency = 'TND';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
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
          onPressed: () => context.pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: CurvedBackground(
        enableAnimation: false,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
            child: EntranceFadeSlide(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(20),
                  Text(t.auth.signUp, style: theme.textTheme.headlineLarge),
                  const Gap(12),
                  Text(
                    'Join Autivo to track your vehicle maintenance with ease.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(32),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: _firstNameController,
                                label: t.auth.firstName,
                                hint: 'John',
                                textInputAction: TextInputAction.next,
                                validator: (v) => Validators.name(
                                  v,
                                  fieldName: t.auth.firstName,
                                ),
                              ),
                            ),
                            const Gap(16),
                            Expanded(
                              child: AppTextField(
                                controller: _lastNameController,
                                label: t.auth.lastName,
                                hint: 'Doe',
                                textInputAction: TextInputAction.next,
                                validator: (v) => Validators.name(
                                  v,
                                  fieldName: t.auth.lastName,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        AppTextField(
                          controller: _emailController,
                          label: t.auth.email,
                          hint: 'your@email.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: Validators.email,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 20,
                          ),
                        ),
                        const Gap(20),
                        AppPasswordField(
                          controller: _passwordController,
                          label: t.auth.password,
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
                        Text(
                          t.profile.preferences,
                          style: theme.textTheme.titleMedium,
                        ),
                        const Gap(16),
                        _buildPreferenceSelectors(context),
                        const Gap(40),
                        SizedBox(
                          height: 56,
                          child: AppButton(
                            onPressed: authVM.isLoading ? null : _submit,
                            isLoading: authVM.isLoading,
                            child: Text(
                              t.auth.signUp,
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
                  const Gap(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.auth.alreadyHaveAccount,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          t.auth.signIn,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceSelectors(BuildContext context) {
    final t = context.t;
    return Column(
      children: [
        _buildSelectField(
          label: t.profile.language,
          value: _selectedLanguage,
          items: [
            DropdownMenuItem(value: 'en', child: Text(t.profile.english)),
            DropdownMenuItem(value: 'fr', child: Text(t.profile.french)),
            DropdownMenuItem(value: 'ar', child: Text(t.profile.arabic)),
          ],
          onChanged: (v) => setState(() => _selectedLanguage = v!),
        ),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _buildSelectField(
                label: t.profile.distanceUnit,
                value: _selectedDistanceUnit,
                items: [
                  DropdownMenuItem(
                    value: 'km',
                    child: Text(t.profile.kilometers),
                  ),
                  DropdownMenuItem(value: 'mi', child: Text(t.profile.miles)),
                ],
                onChanged: (v) => setState(() => _selectedDistanceUnit = v!),
              ),
            ),
            const Gap(16),
            Expanded(
              child: _buildSelectField(
                label: t.profile.currency,
                value: _selectedCurrency,
                items: [
                  DropdownMenuItem(
                    value: 'TND',
                    child: Text(t.profile.tunisianDinar),
                  ),
                  DropdownMenuItem(value: 'EUR', child: Text(t.profile.euro)),
                  DropdownMenuItem(
                    value: 'USD',
                    child: Text(t.profile.usDollar),
                  ),
                ],
                onChanged: (v) => setState(() => _selectedCurrency = v!),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectField({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final preferences = UserPreferences(
      language: _selectedLanguage,
      distanceUnit: _selectedDistanceUnit,
      currency: _selectedCurrency,
    );

    final success = await context.read<AuthViewModel>().register(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      preferences: preferences,
    );

    if (success && mounted) {
      context.read<LocaleController>().setLocale(Locale(_selectedLanguage));
      context.go('/');
    }
  }
}
