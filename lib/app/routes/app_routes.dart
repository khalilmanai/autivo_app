import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/viewmodels/auth_viewmodel.dart';
import '../../presentation/views/auth/forgot_password_screen.dart';
import '../../presentation/views/auth/login_screen.dart';
import '../../presentation/views/auth/onboarding_screen.dart';
import '../../presentation/views/auth/register_screen.dart';
import '../../presentation/views/auth/reset_password_screen.dart';
import '../../presentation/views/auth/splash_screen.dart';
import '../../presentation/views/catalog/catalog_screen.dart';
import '../../presentation/views/garage/add_car_screen.dart';
import '../../presentation/views/garage/car_detail_screen.dart';
import '../../presentation/views/garage/garage_screen.dart';
import '../../presentation/views/garage/vin_decode_screen.dart';
import '../../presentation/views/health/health_screen.dart';
import '../../presentation/views/profile/profile_screen.dart';
import '../../presentation/views/profile/security_screen.dart';
import '../../presentation/views/profile/settings_screen.dart';
import '../../presentation/views/services/add_maintenance_screen.dart';
import '../../presentation/views/services/maintenance_detail_screen.dart';
import '../../presentation/views/services/maintenance_screen.dart';
import '../../presentation/views/shell/main_shell.dart';

/// Paths that only make sense while signed out.
const _guestOnlyPaths = <String>{
  '/login',
  '/register',
  '/forgot-password',
  '/reset-password',
  '/onboarding',
};

const _splashPath = '/splash';

/// Wraps [child] in a slide + fade page transition.
///
/// Every non-tab route in the app uses this so navigation feels uniform
/// instead of relying on per-platform defaults that differ from the app's
/// custom theme.
CustomTransitionPage<T> _slidePage<T>({
  required LocalKey? key,
  required Widget child,
  Offset begin = const Offset(0, 0.06),
}) {
  return CustomTransitionPage<T>(
    key: key,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 240),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Scale-in transition used for hero destinations (login, register, onboarding)
/// so entry into the app feels like arriving rather than sliding a form in.
CustomTransitionPage<T> _fadeScalePage<T>({
  required LocalKey? key,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: key,
    transitionDuration: const Duration(milliseconds: 380),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

GoRouter createRouter(AuthViewModel authVM) {
  return GoRouter(
    initialLocation: _splashPath,

    // Guards the tree: signed-out users are bounced to /login, signed-in users
    // away from the guest-only screens. `/splash` is exempt because it is the
    // screen that performs the bootstrap check and then redirects itself.
    redirect: (context, state) {
      final location = state.matchedLocation;

      if (location == _splashPath) return null;

      final isAuthenticated = authVM.isAuthenticated;
      final isGuestRoute = _guestOnlyPaths.contains(location);

      if (!isAuthenticated && !isGuestRoute) return '/login';
      if (isAuthenticated && isGuestRoute) return '/garage';

      return null;
    },

    routes: [
      GoRoute(
        path: _splashPath,
        pageBuilder: (context, state) =>
            _fadeScalePage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) =>
            _fadeScalePage(key: state.pageKey, child: const OnboardingScreen()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            _fadeScalePage(key: state.pageKey, child: const LoginScreen()),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) =>
            _slidePage(key: state.pageKey, child: const RegisterScreen()),
      ),
      GoRoute(
        path: '/forgot-password',
        pageBuilder: (context, state) =>
            _slidePage(key: state.pageKey, child: const ForgotPasswordScreen()),
      ),
      GoRoute(
        path: '/reset-password',
        pageBuilder: (context, state) => _slidePage(
          key: state.pageKey,
          child: ResetPasswordScreen(
            token: state.uri.queryParameters['token'] ?? '',
          ),
        ),
      ),

      // Everything below renders inside the persistent bottom-nav shell.
      ShellRoute(
        builder: (context, state, child) =>
            MainShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: '/',
            // The index tab replaces rather than stacks, so switching tabs
            // never grows an unbounded back stack.
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const GarageScreen()),
          ),
          GoRoute(
            path: '/garage',
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const GarageScreen()),
          ),
          GoRoute(
            path: '/garage/add',
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const AddCarScreen()),
          ),
          GoRoute(
            path: '/garage/vin-decode',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              begin: const Offset(0, 0.10),
              child: const VinDecodeScreen(),
            ),
          ),
          GoRoute(
            path: '/garage/car/:id',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              child: CarDetailScreen(carId: state.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/health',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              child: HealthScreen(
                carId: state.uri.queryParameters['carId'] ?? '',
              ),
            ),
          ),
          GoRoute(
            path: '/services',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              child: const MaintenanceScreen(),
            ),
          ),
          GoRoute(
            path: '/services/add',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              begin: const Offset(0, 0.10),
              child: AddMaintenanceScreen(
                carId: state.uri.queryParameters['carId'] ?? '',
              ),
            ),
          ),
          GoRoute(
            path: '/services/:id',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              child: MaintenanceDetailScreen(
                maintenanceId: state.pathParameters['id']!,
                carId: state.uri.queryParameters['carId'] ?? '',
              ),
            ),
          ),
          GoRoute(
            path: '/catalog',
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const CatalogScreen()),
          ),
          GoRoute(
            // Focused vehicle chooser opened from the Add Car form. It pops a
            // `CatalogVehicleSelection` back to its caller. Tapping a bottom
            // nav tab uses `context.go`, which discards this route rather than
            // stranding it on the stack.
            path: '/catalog/picker',
            pageBuilder: (context, state) => _slidePage(
              key: state.pageKey,
              child: const CatalogScreen(pickerMode: true),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const ProfileScreen()),
          ),
          GoRoute(
            path: '/profile/settings',
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const SettingsScreen()),
          ),
          GoRoute(
            path: '/profile/security',
            pageBuilder: (context, state) =>
                _slidePage(key: state.pageKey, child: const SecurityScreen()),
          ),
        ],
      ),
    ],
  );
}
