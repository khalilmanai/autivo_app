import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../core/storage/prefs_service.dart';
import '../common_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    final pages = [
      (
        title: t.profile.welcome,
        subtitle: t.profile.welcomeSubtitle,
        lottieAsset: 'assets/lottie/car_animation.json',
      ),
      (
        title: t.garage.garage,
        subtitle: t.garage.noVehiclesSubtitle,
        lottieAsset: 'assets/lottie/garage_animation.json',
      ),
      (
        title: t.services.services,
        subtitle: t.services.maintenanceRecords,
        lottieAsset: 'assets/lottie/maintenance_animation.json',
      ),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CurvedBackground(
        enableAnimation: false,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await PrefsService.setFirstLaunchDone();
                      // `MaterialApp.router` exposes no `routes` map, so
                      // `pushNamedAndRemoveUntil` would throw here.
                      if (!context.mounted) return;
                      context.go('/login');
                    },
                    child: Text(
                      t.common.skip,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: EntranceFadeSlide(
                        index: index,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.05,
                                  ),
                                ),
                                child: Lottie.asset(
                                  page.lottieAsset,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) => Center(
                                    child: Icon(
                                      Icons.directions_car_filled_rounded,
                                      size: 100,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(48),
                            Text(
                              page.title,
                              style: theme.textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                            const Gap(16),
                            Text(
                              page.subtitle,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pages.length, (index) {
                        final isCurrent = _currentPage == index;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeOutCubic,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isCurrent ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: isCurrent
                                ? LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.3),
                                      Colors.transparent,
                                    ],
                                  )
                                : null,
                            color: isCurrent
                                ? null
                                : theme.colorScheme.outlineVariant,
                          ),
                        );
                      }),
                    ),
                    const Gap(40),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: AppButton(
                        onPressed: () async {
                          if (_currentPage < pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutCubic,
                            );
                          } else {
                            await PrefsService.setFirstLaunchDone();
                            if (!context.mounted) return;
                            context.go('/login');
                          }
                        },
                        child: Text(
                          _currentPage < pages.length - 1
                              ? t.common.next
                              : t.profile.getStarted,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
