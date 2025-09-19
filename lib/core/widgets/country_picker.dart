import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/theme/app_colors.dart';

class CountryCodePhoneField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CountryCodePhoneField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintTextStyle,
    this.textStyle,
    this.validator,
    this.onChanged,
  });

  @override
  State<CountryCodePhoneField> createState() => _CountryCodePhoneFieldState();
}

class _CountryCodePhoneFieldState extends State<CountryCodePhoneField> {
  Country _selectedCountry = Country(
    phoneCode: '92',
    countryCode: 'PK',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Pakistan',
    example: '3001234567',
    displayName: 'Pakistan',
    displayNameNoCountryCode: 'Pakistan',
    e164Key: '',
  );

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: state.hasError ? Colors.red : Colors.grey),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: _showCountryPicker,
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Text(
                            _selectedCountry.flagEmoji,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_drop_down, size: 24, color: Colors.black87),
                          const SizedBox(width: 6),
                          Text(
                            '+${_selectedCountry.phoneCode}',
                            style: widget.textStyle ?? const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextFormField(
                        controller: widget.controller,
                        onChanged: (v) {
                          state.didChange(v);
                          if (widget.onChanged != null) widget.onChanged!(v);
                        },
                        cursorColor: AppColors.oceanBlue,
                        keyboardType: TextInputType.phone,
                        style: widget.textStyle,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          hintStyle: widget.hintTextStyle,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          errorStyle: const TextStyle(height: 0, fontSize: 0),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                AppAssets.phone,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints.tightFor(width: 36, height: 36),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 6),
                child: Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
