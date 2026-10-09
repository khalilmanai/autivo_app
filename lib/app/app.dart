import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/localization/locale_controller.dart';
import '../core/localization/theme_controller.dart';
import '../di.dart';
import '../l10n/translations/strings.g.dart';
import '../presentation/viewmodels/auth_viewmodel.dart';
import '../presentation/viewmodels/car_part_viewmodel.dart'
    show CarPartViewModel;
import '../presentation/viewmodels/catalog_viewmodel.dart'
    show CatalogViewModel;
import '../presentation/viewmodels/garage_viewmodel.dart' show GarageViewModel;
import '../presentation/viewmodels/maintenance_viewmodel.dart'
    show MaintenanceViewModel;
import '../presentation/viewmodels/user_viewmodel.dart' show UserViewModel;
import 'routes/app_routes.dart';

class AutivoApp extends StatefulWidget {
  const AutivoApp({super.key});

  @override
  State<AutivoApp> createState() => _AutivoAppState();
}

class _AutivoAppState extends State<AutivoApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    final authVM = getIt<AuthViewModel>();
    _router = createRouter(authVM);
    authVM.addListener(_onAuthChanged);
  }

  void _onAuthChanged() {
    if (!mounted) return;
    _router.refresh();
  }

  @override
  void dispose() {
    getIt<AuthViewModel>().removeListener(_onAuthChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<AuthViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<UserViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<GarageViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<CarPartViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<MaintenanceViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<CatalogViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<LocaleController>()),
        ChangeNotifierProvider(create: (_) => getIt<ThemeController>()),
      ],
      child: Consumer3<LocaleController, ThemeController, AuthViewModel>(
        builder: (context, localeCtrl, themeCtrl, authVM, _) {
          return TranslationProvider(
            child: MaterialApp.router(
              title: 'Autivo',
              debugShowCheckedModeBanner: false,
              theme: themeCtrl.themeData,
              locale: localeCtrl.locale,
              routerConfig: _router,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocale.values
                  .map((e) => e.flutterLocale)
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
