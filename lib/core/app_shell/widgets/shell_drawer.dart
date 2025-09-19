import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import '../models/drawer_entry.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class ShellDrawer extends StatelessWidget {
  final bool isGuest;
  final List<DrawerEntry> entries;
  final void Function(DrawerEntry) onEntryTap;
  final VoidCallback onLoginOrLogout;
  final String? userName;
  final String? userImageUrl;

  const ShellDrawer({
    super.key,
    required this.isGuest,
    required this.entries,
    required this.onEntryTap,
    required this.onLoginOrLogout,
    this.userName,
    this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      width: width * 0.86,
      child: SafeArea(
        child: Container(
          color: const Color(0xFFF6F8FC),
          child: Column(
            children: [
              // ===== Header =====
              _DrawerHeader(
                isGuest: isGuest,
                userName: userName,
                userImageUrl: userImageUrl,
              ),

              // ===== Entries =====
              Expanded(
                child: ListView.separated(
                  padding:
                      AppSpacing.paddingH16V12.copyWith(top: 12, bottom: 12),
                  itemCount: entries.length,
                  separatorBuilder: (_, __) => AppSpacing.height8,
                  itemBuilder: (context, i) {
                    final e = entries[i];
                    if (e.isDivider) return const SizedBox(height: 8);
                    final locked = isGuest && (e.requiresAuth);
                    return _DrawerTile(
                      icon: e.icon!,
                      label: e.label,
                      locked: locked,
                      onTap: () => onEntryTap(e),
                    );
                  },
                ),
              ),

              // ===== Footer CTA =====
              Padding(
                padding: AppSpacing.paddingH16V12,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        width: double.infinity,
                        text: isGuest ? 'Login / Sign up' : 'Logout',
                        onPressed: onLoginOrLogout,
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

class _DrawerHeader extends StatelessWidget {
  final bool isGuest;
  final String? userName;
  final String? userImageUrl;
  const _DrawerHeader({required this.isGuest, this.userName, this.userImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.skyBlueMid, AppColors.royalBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.paddingH16V12,
            child: Row(
              children: [
                // Avatar with ring
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: CachedNetworkImage(
                              imageUrl: (isGuest || userImageUrl == null || userImageUrl!.isEmpty)
                                  ? 'https://i.pravatar.cc/150?u=guest'
                                  : userImageUrl!,
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                              placeholder: (c, _) => const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              ),
                              errorWidget: (c, _, __) => const Icon(
                                Icons.person_rounded,
                                color: AppColors.royalBlue,
                                size: 28,
                              ),
                            ),
                    ),
                  ),
                ),
                AppSpacing.width12,

                // Text block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: Name on left, Access chip pinned to right
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              isGuest ? 'Guest' : (userName ?? 'User'),
                              style: AppTextStyles.inter400White16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Keep chip on the right; shrink gracefully if very tight
                          Flexible(
                            fit: FlexFit.loose,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: _AccessChip(
                                label:
                                    isGuest ? 'Limited access' : 'Full access',
                                icon: isGuest
                                    ? Icons.lock_rounded
                                    : Icons.verified_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.height4,

                      // Second line: subtitle with ellipsis (no chip here)
                      Text(
                        isGuest ? 'Sign in for full features' : 'Welcome back',
                        style: AppTextStyles.heading3White,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _AccessChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.heading3White),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool locked;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.locked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tile = InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: locked
                ? AppColors.neutralLight.withOpacity(.8)
                : AppColors.neutralLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            _IconBadge(icon: icon),
            AppSpacing.width12,
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.inter400Black16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AppSpacing.width8,
            if (locked)
              _LockPill()
            else
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.neutralDarkGray),
          ],
        ),
      ),
    );

    // Slight dim for locked tiles but keep tappable (upstream can guard)
    return Opacity(
      opacity: locked ? 0.85 : 1,
      child: tile,
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  const _IconBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.skyBlueMid, AppColors.royalBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalBlue.withOpacity(.10),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white24, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ).foreground(icon);
  }
}

class _LockPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_rounded, size: 14, color: Color(0xFFB26A00)),
          const SizedBox(width: 6),
          Text('Locked', style: AppTextStyles.heading3Regular),
        ],
      ),
    );
  }
}

/// Small extension to stack an icon over a container neatly
extension _IconOverlay on Widget {
  Widget foreground(IconData icon) {
    return Stack(
      alignment: Alignment.center,
      children: [
        this,
        Icon(icon, color: Colors.white, size: 20),
      ],
    );
  }
}
