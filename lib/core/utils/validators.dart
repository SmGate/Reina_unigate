class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value.trim()) ? null : 'Enter a valid email';
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Password is required';
    if (value.length < 8) return 'Minimum 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Add at least 1 uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Add at least 1 number';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10 ? null : 'Enter a valid phone number';
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) return 'Enter only letters';
    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    return (value == null || value.trim().isEmpty)
        ? '$fieldName cannot be empty'
        : null;
  }
}
