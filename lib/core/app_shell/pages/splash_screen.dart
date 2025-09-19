import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/core/services/app_prefs.dart';
import 'package:unigate/injection/injection_container.dart';
import 'package:unigate/features/auth/data/datasource/local_data_source/auth_local_data_source.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(_decideRoute);
  }

  Future<void> _decideRoute() async {
    final prefs = sl<AppPrefs>();
    await Future.delayed(const Duration(milliseconds: 800));

    if (!prefs.hasSeenOnboarding) {
      context.goNamed(Routes.onboarding.name);
      return;
    }

    // If guest or logged-in user, go to home (app shell); else to login
    final isGuest = prefs.isGuest;
    // Check cached login
    final cached = await sl<AuthLocalDataSource>().getCachedLogin();
    if (isGuest || cached != null) {
      context.goNamed(Routes.appShell.name);
    } else {
      context.goNamed(Routes.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssets.mainIcons),
      ),
    );
  }
}


