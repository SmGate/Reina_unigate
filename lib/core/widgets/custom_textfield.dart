import 'package:flutter/material.dart';
import 'package:unigate/core/theme/app_colors.dart';

class RoundedInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Widget? suffix; // Custom suffix (e.g., icon/text)
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const RoundedInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintTextStyle,
    this.textStyle,
    this.suffix,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.textInputAction,
    this.keyboardType,
  });

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          return TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: widget.textStyle,
            cursorColor: AppColors.oceanBlue,
            obscureText: _obscureText,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Show custom suffix if provided
                  if (widget.suffix != null) widget.suffix!,
                  // Show eye icon if password field
                  if (widget.isPassword)
                    IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: _toggleVisibility,
                    ),
                ],
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          );
        },
      ),
      onFocusChange: (_) {},
    );
  }
}
