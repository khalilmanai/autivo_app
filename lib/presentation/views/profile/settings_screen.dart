import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/localization/locale_controller.dart';
import '../../../core/localization/theme_controller.dart';
import '../../../data/models/user.dart' show UserPreferences;
import '../../viewmodels/user_viewmodel.dart';
import '../common_view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'en';
  String _selectedDistanceUnit = 'km';
  String _selectedCurrency = 'TND';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<UserViewModel>().user;
      if (user != null) {
        setState(() {
          _selectedLanguage = user.preferences.language;
          _selectedDistanceUnit = user.preferences.distanceUnit;
          _selectedCurrency = user.preferences.currency;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final userVM = context.watch<UserViewModel>();
    final themeCtrl = context.watch<ThemeController>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(t.profile.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, t.profile.appearance),
            const Gap(16),
            EntranceFadeSlide(
              child: AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette_rounded,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const Gap(12),
                        Text(
                          t.profile.theme,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<ThemePreference>(
                        segments: [
                          ButtonSegment(
                            value: ThemePreference.white,
                            label: Text(t.profile.themeWhite),
                            icon: const Icon(
                              Icons.light_mode_rounded,
                              size: 16,
                            ),
                          ),
                          ButtonSegment(
                            value: ThemePreference.black,
                            label: Text(t.profile.themeBlack),
                            icon: const Icon(Icons.dark_mode_rounded, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemePreference.nightOwl,
                            label: Text('Night'),
                            icon: const Icon(Icons.nightlight_round, size: 16),
                          ),
                        ],
                        selected: {themeCtrl.preference},
                        showSelectedIcon: false,
                        style: const ButtonStyle(
                          visualDensity: VisualDensity.compact,
                        ),
                        onSelectionChanged: (selection) {
                          context.read<ThemeController>().setPreference(
                            selection.first,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(32),
            _buildSectionTitle(context, t.profile.preferences),
            const Gap(16),
            EntranceFadeSlide(
              index: 1,
              child: _buildPreferenceTile(
                context,
                t.profile.language,
                t.profile.selectLanguage,
                _selectedLanguage,
                [
                  DropdownMenuItem(value: 'en', child: Text(t.profile.english)),
                  DropdownMenuItem(value: 'fr', child: Text(t.profile.french)),
                  DropdownMenuItem(value: 'ar', child: Text(t.profile.arabic)),
                ],
                (v) => _updatePreference(language: v),
                icon: Icons.translate_rounded,
              ),
            ),
            const Gap(16),
            EntranceFadeSlide(
              index: 2,
              child: _buildPreferenceTile(
                context,
                t.profile.distanceUnit,
                t.profile.selectDistanceUnit,
                _selectedDistanceUnit,
                [
                  DropdownMenuItem(
                    value: 'km',
                    child: Text(t.profile.kilometers),
                  ),
                  DropdownMenuItem(value: 'mi', child: Text(t.profile.miles)),
                ],
                (v) => _updatePreference(distanceUnit: v),
                icon: Icons.straighten_rounded,
              ),
            ),
            const Gap(16),
            EntranceFadeSlide(
              index: 3,
              child: _buildPreferenceTile(
                context,
                t.profile.currency,
                t.profile.selectCurrency,
                _selectedCurrency,
                [
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
                (v) => _updatePreference(currency: v),
                icon: Icons.payments_rounded,
              ),
            ),
            if (userVM.error != null) ...[
              const Gap(24),
              ErrorFeedback(error: userVM.error),
            ],
            const Gap(40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildPreferenceTile(
    BuildContext context,
    String label,
    String hint,
    String value,
    List<DropdownMenuItem<String>> items,
    ValueChanged<String> onChanged, {
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const Gap(12),
              Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Gap(16),
          DropdownButtonFormField<String>(
            initialValue: value,
            items: items,
            onChanged: (v) => onChanged(v!),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updatePreference({
    String? language,
    String? distanceUnit,
    String? currency,
  }) async {
    if (_isLoading) return;

    final localeController = context.read<LocaleController>();
    final userVM = context.read<UserViewModel>();

    // Applied optimistically so the whole app switches instantly; reverted if
    // the request fails, otherwise the UI and the server disagree.
    final previousLocale = localeController.locale;

    setState(() => _isLoading = true);

    try {
      if (language != null) {
        await localeController.setLocale(Locale(language));
      }

      final prefs = UserPreferences(
        language: language ?? _selectedLanguage,
        distanceUnit: distanceUnit ?? _selectedDistanceUnit,
        currency: currency ?? _selectedCurrency,
      );

      final success = await userVM.updatePreferences(prefs);
      if (!mounted) return;

      if (success) {
        setState(() {
          if (language != null) _selectedLanguage = language;
          if (distanceUnit != null) _selectedDistanceUnit = distanceUnit;
          if (currency != null) _selectedCurrency = currency;
        });
      } else if (language != null) {
        await localeController.setLocale(previousLocale);
        if (!mounted) return;
        setState(() => _selectedLanguage = _localeToLanguage(previousLocale));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Maps the active locale back to the stored language code.
  String _localeToLanguage(Locale locale) {
    if (locale.languageCode.isEmpty) return _selectedLanguage;
    return locale.languageCode;
  }
}
