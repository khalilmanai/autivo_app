import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/storage/prefs_service.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../common_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final authVM = context.read<AuthViewModel>();

    try {
      final start = DateTime.now();
      final loggedIn = await authVM.tryAutoLogin();

      final elapsed = DateTime.now().difference(start);
      const minimumSplash = Duration(milliseconds: 1600);
      if (elapsed < minimumSplash) {
        await Future.delayed(minimumSplash - elapsed);
      }

      if (!mounted) return;

      if (loggedIn) {
        context.go('/');
      } else if (PrefsService.isFirstLaunch()) {
        context.go('/onboarding');
      } else {
        context.go('/login');
      }
    } catch (_) {
      if (mounted) context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CurvedBackground(
        enableAnimation: false,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        size: 60,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const Gap(32),
                Text(
                  'Autivo',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.5,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap(8),
                Text(
                  'SMART VEHICLE MANAGEMENT',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const Gap(64),
                const AppLoader(size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
