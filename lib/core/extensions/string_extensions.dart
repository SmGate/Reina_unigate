extension StringValidators on String {
  bool get isValidEmail =>
      RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);

  bool get isValidPhone => RegExp(r"^[0-9]{10,15}$").hasMatch(this);

  bool get isNumeric => RegExp(r'^-?[0-9]+$').hasMatch(this);

  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  bool get isStrongPassword =>
      length >= 8 &&
      RegExp(r'[A-Z]').hasMatch(this) &&
      RegExp(r'[a-z]').hasMatch(this) &&
      RegExp(r'[0-9]').hasMatch(this) &&
      RegExp(r'[!@#\$&*~]').hasMatch(this);

  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
