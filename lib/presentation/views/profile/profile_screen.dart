import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../common_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final userVM = context.watch<UserViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(t.profile.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: userVM.isLoading
          ? const Center(child: AppLoader())
          : userVM.user == null
          ? EmptyState(title: 'No profile data', icon: Icons.person_off_rounded)
          : RefreshIndicator(
              onRefresh: () => userVM.loadProfile(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    EntranceFadeSlide(
                      child: _buildProfileHeader(context, userVM.user!),
                    ),
                    const Gap(32),
                    EntranceFadeSlide(
                      index: 1,
                      child: _buildSectionTitle(context, 'Account Settings'),
                    ),
                    const Gap(12),
                    EntranceFadeSlide(
                      index: 2,
                      child: _buildMenuItems(context),
                    ),
                    const Gap(32),
                    EntranceFadeSlide(
                      index: 3,
                      child: _buildSectionTitle(context, 'Support'),
                    ),
                    const Gap(12),
                    EntranceFadeSlide(
                      index: 4,
                      child: _buildSupportItems(context),
                    ),
                    const Gap(32),
                    EntranceFadeSlide(
                      index: 5,
                      child: AppCard(
                        padding: EdgeInsets.zero,
                        color: theme.colorScheme.error.withValues(alpha: 0.05),
                        border: BorderSide(
                          color: theme.colorScheme.error.withValues(alpha: 0.1),
                        ),
                        child: _MenuItem(
                          icon: Icons.logout_rounded,
                          title: t.profile.logout,
                          subtitle: 'Sign out of your account',
                          onTap: () => _confirmLogout(context),
                          isDestructive: true,
                        ),
                      ),
                    ),
                    const Gap(40),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic user) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.15),
                    theme.colorScheme.secondary.withValues(alpha: 0.05),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 54,
                backgroundColor: theme.colorScheme.surface,
                backgroundImage: user.avatar != null && user.avatar!.isNotEmpty
                    ? NetworkImage(user.avatar!)
                    : null,
                child: user.avatar == null || user.avatar!.isEmpty
                    ? Text(
                        user.fullName.isNotEmpty
                            ? user.fullName[0].toUpperCase()
                            : '?',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    : null,
              ),
            ),
            GestureDetector(
              onTap: _pickAvatar,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.scaffoldBackgroundColor,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
        Text(
          user.fullName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const Gap(4),
        Text(
          user.email,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatusBadge(status: user.authProvider),
            if (user.isEmailVerified) ...[
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: StatusColors.active.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: StatusColors.active.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: StatusColors.active,
                    ),
                    const Gap(6),
                    Text(
                      'Verified',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: StatusColors.active,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final t = context.t;
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _MenuItem(
            icon: Icons.person_outline_rounded,
            title: 'Personal Info',
            subtitle: 'Name, email, and avatar',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 64),
          _MenuItem(
            icon: Icons.settings_outlined,
            title: t.profile.settings,
            subtitle: 'Language, units, and appearance',
            onTap: () => context.push('/profile/settings'),
          ),
          const Divider(height: 1, indent: 64),
          _MenuItem(
            icon: Icons.security_rounded,
            title: t.profile.security,
            subtitle: 'Password and account access',
            onTap: () => context.push('/profile/security'),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportItems(BuildContext context) {
    final t = context.t;
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _MenuItem(
            icon: Icons.help_outline_rounded,
            title: 'Help Center',
            subtitle: 'FAQ and customer support',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 64),
          _MenuItem(
            icon: Icons.info_outline_rounded,
            title: t.profile.about,
            subtitle: 'Version and legal info',
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  void _pickAvatar() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      // TODO: Upload avatar
    }
  }

  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);
    AppBottomSheet.show(
      context: context,
      title: const Text('Autivo'),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version 1.0.0',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Gap(8),
            Text(
              'Autivo is your smart vehicle management and maintenance tracking companion. Keep your car in top shape with ease.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const Gap(24),
            Text(
              'Technical Info',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Gap(8),
            _DetailRowSmall(label: 'Environment', value: 'Production'),
            _DetailRowSmall(label: 'Server Status', value: 'Connected'),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    final t = context.t;
    // The dialog's builder shadows `context` with the route that is about to
    // be popped, so hold on to the page's context for the post-await guard.
    final pageContext = context;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.profile.logout),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () async {
              final authVM = dialogContext.read<AuthViewModel>();
              Navigator.of(dialogContext).pop();
              await authVM.logout();
              // `MaterialApp.router` has no `routes` map, so
              // `pushNamedAndRemoveUntil` would throw here.
              if (!pageContext.mounted) return;
              pageContext.go('/login');
            },
            child: Text(
              t.profile.logout,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRowSmall extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRowSmall({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDestructive
              ? theme.colorScheme.error.withValues(alpha: 0.1)
              : theme.colorScheme.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          icon,
          size: 22,
          color: isDestructive
              ? theme.colorScheme.error
              : theme.colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive
              ? theme.colorScheme.error
              : theme.colorScheme.onSurface,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 14,
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
      ),
      onTap: onTap,
    );
  }
}
