import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

enum AppModalType { success, error, warning, info }

Future<void> showAppModal(
  BuildContext context, {
  required String message,
  String? title,
  AppModalType type = AppModalType.info,
  String primaryLabel = 'OK',
  VoidCallback? onPrimary,
  String? secondaryLabel,
  VoidCallback? onSecondary,
  bool barrierDismissible = true,
}) {
  final Color accent = switch (type) {
    AppModalType.success => AppColors.skyBlueDark, // your brand accent
    AppModalType.error => AppColors.red,
    AppModalType.warning => const Color(0xFFF59E0B), // amber-ish
    AppModalType.info => const Color(0xFF3B82F6), // blue-ish
  };

  // We opt for a clean, text-first header. No leading icons for a modern look.
  IconData? icon;

  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dialog',
    barrierColor: Colors.black.withOpacity(0.25),
    transitionDuration: const Duration(milliseconds: 160),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (context, anim, __, ___) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420, // looks premium on tablets/desktops
                minWidth: 320,
              ),
              child: _ModalCard(
                title: title,
                message: message,
                accent: accent,
                icon: icon,
                primaryLabel: primaryLabel,
                onPrimary: () {
                  Navigator.of(context).pop();
                  onPrimary?.call();
                },
                secondaryLabel: secondaryLabel,
                onSecondary: secondaryLabel == null
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        onSecondary?.call();
                      },
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _ModalCard extends StatelessWidget {
  const _ModalCard({
    required this.message,
    required this.accent,
    required this.icon,
    required this.primaryLabel,
    this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.title,
  });

  final String? title;
  final String message;
  final Color accent;
  final IconData? icon;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    // Clean white card with subtle radius
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.displayMediumBold.copyWith(
                            color: accent,
                            fontSize: 18,
                            height: 1.2,
                          ),
                        ),
                      ),
                      InkResponse(
                        onTap: () => Navigator.of(context).pop(),
                        radius: 18,
                        child: const Padding(
                          padding: EdgeInsets.all(4),
                          child: Icon(Icons.close_rounded, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 3,
                      width: 56,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Body – scrollable if long
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 8),
                        child: Text(
                          message,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.heading3Light.copyWith(
                            color: Colors.black.withOpacity(0.75),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Actions
                  Row(
                    children: [
                      if (secondaryLabel != null) ...[
                        Expanded(
                          child: _SecondaryButton(
                            label: secondaryLabel!,
                            onTap: onSecondary,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Expanded(
                        child: _PrimaryButton(
                          label: primaryLabel,
                          onTap: onPrimary,
                          accent: accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.onTap,
    required this.accent,
  });

  final String label;
  final VoidCallback? onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: AppTextStyles.heading3Light.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.black.withOpacity(0.12)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: AppTextStyles.heading3Light.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
