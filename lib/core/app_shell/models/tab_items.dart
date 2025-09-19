import 'package:flutter/material.dart';

typedef ScreenBuilder = Widget Function();

class TabItem {
  final String label;
  final IconData icon;
  final bool requiresAuth;
  final bool useShellAppBar; // if false, the screen renders its own AppBar
  final ScreenBuilder builder;

  TabItem({
    required this.label,
    required this.icon,
    required this.requiresAuth,
    required this.builder,
    this.useShellAppBar = true,
  });
}
