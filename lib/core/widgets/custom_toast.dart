import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/theme/app_colors.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final String? imageAsset;
  final Color borderColor;
  final Color backgroundColor;

  const CustomToast({
    super.key,
    required this.message,
    this.imageAsset,
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageAsset != null)
            Image.asset(
              imageAsset!,
              height: 35,
              width: 35,
            )
          else
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_rounded,
                color: borderColor,
              ),
            ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showSuccessToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 80,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: CustomToast(
          message: message,
          imageAsset: AppAssets.success,
          borderColor: AppColors.green,
          backgroundColor: AppColors.green,
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3)).then((_) {
    overlayEntry.remove();
  });
}

void showErrorToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 80,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: CustomToast(
          message: message,
          // No asset to keep it lightweight; uses modern error icon
          imageAsset: null,
          borderColor: AppColors.red,
          backgroundColor: AppColors.red,
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 4)).then((_) {
    overlayEntry.remove();
  });
}
