class InputConverter {
  InputConverter._(); // Prevent instantiation

  static int? stringToUnsignedInt(String input) {
    try {
      final number = int.parse(input.trim());
      return number >= 0 ? number : null;
    } catch (_) {
      return null;
    }
  }

  static String? validateEmail(String input) {
    final email = input.trim();
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email) ? email : null;
  }

  static DateTime? parseDate(String input) {
    try {
      return DateTime.parse(input.trim());
    } catch (_) {
      return null;
    }
  }

  static String? normalizePhone(String input) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 10 ? digits : null;
  }
}
