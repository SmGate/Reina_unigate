// ignore_for_file: unused_field, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/app_shell/models/drawer_entry.dart';
import 'package:unigate/core/app_shell/models/tab_items.dart';
import 'package:unigate/core/app_shell/utils/auth_sheet.dart';
import 'package:unigate/core/app_shell/utils/place_holder.dart';
import 'package:unigate/core/app_shell/widgets/locked_screen.dart';
import 'package:unigate/core/app_shell/widgets/shell_drawer.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/features/application_manager/presentation/pages/application_manager_page.dart';
import 'package:unigate/features/chat_supports/presentation/pages/chat_support_screen.dart';
import 'package:unigate/features/document_center/presentation/pages/document_center.dart';
import 'package:unigate/features/home/presentation/pages/home_page.dart';
import 'package:unigate/features/learn_explore/presentation/pages/learn_explore.dart';
import 'package:unigate/features/test_prep_resources/presentation/pages/test_prep_resources_screen.dart';
import 'package:unigate/features/universatise_explorer/presentation/pages/uni_explored.dart';
import 'package:unigate/features/visa_financial_assitance/presentation/pages/visa_financial_assistance_screen.dart';
import 'package:unigate/features/auth/data/datasource/local_data_source/auth_local_data_source.dart';
import 'package:unigate/injection/injection_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unigate/core/services/app_prefs.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 1;

  bool _isGuest = true;
  bool _bootstrapped = false;
  String? _userName;
  String? _userImage;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // unchanged tabs
  late final List<TabItem> _tabs = [
    TabItem(
      label: 'Home',
      icon: Icons.dashboard_rounded,
      requiresAuth: false,
      builder: () => const StudentAnalyticsHome(),
    ),
    TabItem(
      label: 'Explore',
      icon: Icons.travel_explore_rounded,
      requiresAuth: false,
      builder: () => const UniExplored(),
    ),
    TabItem(
      label: 'Applications',
      icon: Icons.assignment_turned_in_rounded,
      requiresAuth: true,
      builder: () => const ApplicationManagerScreen(),
    ),
    TabItem(
      label: 'Documents',
      icon: Icons.folder_rounded,
      requiresAuth: true,
      builder: () => const DocumentCenterScreen(),
    ),
    TabItem(
      label: 'Support',
      icon: Icons.support_agent_rounded,
      requiresAuth: true,
      builder: () => const ChatSupportScreen(),
    ),
  ];

  // unchanged drawer items
  late final List<DrawerEntry> _drawerItems = [
    DrawerEntry(
      label: 'Visa & Financials',
      icon: Icons.account_balance_wallet_rounded,
      requiresAuth: true,
      builder: () => const VisaFinanceScreen(),
    ),
    DrawerEntry(
      label: 'Test Prep',
      icon: Icons.menu_book_rounded,
      requiresAuth: false,
      builder: () => const TestPrepScreen(),
    ),
    DrawerEntry(
        label: 'Explore & Learn',
        icon: Icons.school_rounded,
        requiresAuth: false,
        builder: () => const ExploreLearnScreen()),
    DrawerEntry.divider(),
    DrawerEntry(
      label: 'Settings',
      icon: Icons.settings_rounded,
      requiresAuth: true,
      builder: () => const PlaceholderScreen('Settings'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final token = sl<AuthLocalDataSource>().getToken();
    final model = await sl<AuthLocalDataSource>().getCachedLogin();
    setState(() {
      _isGuest = token == null || token.isEmpty;
      _userName = model?.fullName;
      _userImage = model?.image;
      _index = 1;
      _bootstrapped = true;
    });
  }

  bool _isTabLocked(TabItem t, int tabIndex) {
    if (!_isGuest) return false; // logged in → never locked
    // As guest, only allow Explore (index 1). Lock all others including Home.
    return tabIndex != 1;
  }

  bool _isDrawerEntryLocked(DrawerEntry entry) {
    if (!_isGuest) return false;
    return entry.requiresAuth;
  }

  @override
  Widget build(BuildContext context) {
    if (!_bootstrapped) {
      return const Scaffold(
        body: SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final current = _tabs[_index];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: _buildAppBar(current),
      drawer: ShellDrawer(
        isGuest: _isGuest,
        entries: _drawerItems,
        onEntryTap: (entry) {
          Navigator.pop(context);
          if (entry.isDivider) return;

          final needsAuth = _isDrawerEntryLocked(entry);
          if (needsAuth) {
            showAuthSheet(
              context,
              title: 'Login required',
              message: 'Please sign in to access ${entry.label}.',
              onSignIn: () => context.goNamed(Routes.login.name),
            );
            return;
          }

          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => entry.builder()),
          );
        },
        onLoginOrLogout: () async {
          Navigator.pop(context);
          if (_isGuest) {
            showAuthSheet(
              context,
              title: 'Welcome to UniGate',
              message: 'Create your account to apply and upload documents.',
              onSignIn: () => context.goNamed(Routes.login.name),
            );
          } else {
            await sl<AuthLocalDataSource>().clearLogin();
            await sl<AppPrefs>().setGuest(true);
            setState(() {
              _isGuest = true;
              _index = 1;
              _userName = null;
              _userImage = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logged out')),
            );
          }
        },
        userName: _userName,
        userImageUrl: _userImage,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _index,
          children: _tabs.asMap().entries.map((e) {
            final i = e.key;
            final t = e.value;
            final locked = _isTabLocked(t, i);
            if (!locked) return t.builder();
            return LockedScreen(
              title: t.label,
              onLogin: () => showAuthSheet(
                context,
                title: 'Login required',
                message:
                    'Please sign in to access ${t.label}. You can continue as guest.',
                onSignIn: () => context.goNamed(Routes.login.name),
              ),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFEAEFF5), width: 1)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.royalBlue,
          unselectedItemColor: AppColors.neutralDarkGray,
          onTap: (i) {
            final t = _tabs[i];
            final locked = _isTabLocked(t, i);
            if (locked) {
              showAuthSheet(
                context,
                title: 'Login required',
                message:
                    'Please sign in to access ${t.label}. You can continue as guest.',
                onSignIn: () => context.goNamed(Routes.login.name),
              );
              return;
            }
            setState(() => _index = i);
          },
          items: _tabs.asMap().entries.map((e) {
            final i = e.key;
            final t = e.value;
            final locked = _isTabLocked(t, i);
            return BottomNavigationBarItem(
              icon: locked
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(t.icon),
                        const Positioned(
                          right: -2,
                          top: -2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: AppColors.royalBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(Icons.lock_rounded,
                                  size: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Icon(t.icon),
              label: t.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(TabItem current) {
    if (!current.useShellAppBar) return null;

    openDrawer() => _scaffoldKey.currentState?.openDrawer();
    onAvatarTap() {
      if (_isGuest) {
        showAuthSheet(
          context,
          title: 'Create your UniGate account',
          message: 'Sign in to unlock applications, documents, and support.',
          onSignIn: () => context.goNamed(Routes.login.name),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_userName ?? 'Open Profile')),
        );
      }
    }

    return AppBar(
      title: Text(
        _isGuest ? current.label : (_userName ?? current.label),
        style: AppTextStyles.displayMediumMedium20,
        overflow: TextOverflow.ellipsis,
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded, color: AppColors.blackish),
        onPressed: openDrawer,
      ),
      actions: [
        const Padding(
          padding: AppSpacing.paddingH8,
          child:
              Icon(Icons.notifications_none_rounded, color: AppColors.blackish),
        ),
        Padding(
          padding: AppSpacing.paddingH8,
          child: GestureDetector(
            onTap: onAvatarTap,
            child: _AvatarSmall(
              imageUrl: _isGuest
                  ? 'https://i.pravatar.cc/100?u=guest'
                  : (_userImage == null || _userImage!.isEmpty)
                      ? 'https://i.pravatar.cc/100?u=${_userName ?? 'user'}'
                      : _userImage!,
            ),
          ),
        ),
      ],
    );
  }
}

class _AvatarSmall extends StatelessWidget {
  final String imageUrl;
  const _AvatarSmall({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.skyBlueMid, AppColors.royalBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 28,
          height: 28,
          fit: BoxFit.cover,
          placeholder: (c, _) => const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          errorWidget: (c, _, __) => const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.royalBlue,
            child: Icon(Icons.person, color: Colors.white, size: 16),
          ),
        ),
      ),
    );
  }
}
