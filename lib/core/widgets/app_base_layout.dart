// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/theme/app_colors.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final bool isSingleChildScrollView;
  final bool showAppBar;
  final String? appBarTitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? padding;
  final Future<bool> Function()? onWillPop;

  const BaseLayout({
    super.key,
    required this.child,
    this.isSingleChildScrollView = false,
    this.showAppBar = false,
    this.appBarTitle,
    this.showBackButton = false,
    this.onBackPressed,
    this.padding,
    this.onWillPop,
  });

  @override
  Widget build(BuildContext context) {
    final content =
        padding != null ? Padding(padding: padding!, child: child) : child;

    return WillPopScope(
      onWillPop: onWillPop ?? () async => true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          extendBodyBehindAppBar: true,
          appBar: showAppBar
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  leading: showBackButton
                      ? IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed:
                              onBackPressed ?? () => Navigator.pop(context),
                        )
                      : null,
                  title: appBarTitle != null
                      ? Text(appBarTitle!,
                          style: const TextStyle(color: Colors.white))
                      : null,
                )
              : null,
          body: Stack(
            children: [
              // Background Image
              Image.asset(
                AppAssets.background,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),

              // Main content
              isSingleChildScrollView
                  ? SingleChildScrollView(child: content)
                  : content,
            ],
          ),
        ),
      ),
    );
  }
}
