import 'package:flutter/material.dart';

typedef ScreenBuilder = Widget Function();

class DrawerEntry {
  final String label;
  final IconData? icon;
  final bool requiresAuth;
  final ScreenBuilder? _builder;
  final bool isDivider;

  DrawerEntry({
    required this.label,
    required this.icon,
    required this.requiresAuth,
    ScreenBuilder? builder,
  })  : _builder = builder,
        isDivider = false;

  DrawerEntry._divider()
      : label = '',
        icon = null,
        requiresAuth = false,
        _builder = null,
        isDivider = true;

  factory DrawerEntry.divider() => DrawerEntry._divider();

  Widget builder() => (_builder ?? () => const SizedBox.shrink()).call();
}
