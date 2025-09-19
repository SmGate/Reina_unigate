import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  // Styling
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double? width; // ✅ NEW

  // Icon
  final Widget? icon;
  final double iconSpacing;

  // Loading
  final bool isLoading;
  final Widget? loadingWidget;

  // Circular mode (for onboarding arrows etc.)
  final bool isRounded;
  final Widget? roundedIcon;
  final VoidCallback? onRoundedPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.textStyle,
    this.borderColor,
    this.borderRadius = 12.0,
    this.horizontalPadding = 16.0,
    this.verticalPadding = 12.0,
    this.width, // ✅ NEW
    this.icon,
    this.iconSpacing = 8.0,
    this.isLoading = false,
    this.loadingWidget,
    this.isRounded = false,
    this.roundedIcon,
    this.onRoundedPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Circle button mode for onboarding
    if (isRounded) {
      return InkWell(
        onTap: isLoading ? null : onRoundedPressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.blue,
            shape: BoxShape.circle,
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
          ),
          child: Center(
            child: isLoading
                ? (loadingWidget ??
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ))
                : (roundedIcon ??
                    const Icon(Icons.arrow_forward, color: Colors.white)),
          ),
        ),
      );
    }

    final bool hasIcon = icon != null && !isLoading;

    return SizedBox(
      // ✅ SizedBox allows you to apply width
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? Colors.blue,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderColor != null ? 1.5 : 0,
            ),
          ),
        ),
        child: isLoading
            ? (loadingWidget ??
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ))
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasIcon) icon!,
                  if (hasIcon) SizedBox(width: iconSpacing),
                  Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          color: textColor ?? Colors.white,
                          fontSize: fontSize ?? 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
