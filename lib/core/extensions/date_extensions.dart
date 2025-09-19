extension DateFormatting on DateTime {
  /// Returns the date in dd/MM/yyyy format
  String get toShortDate =>
      '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

  /// Returns the date in yyyy-MM-dd format
  String get toIsoDate =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  /// Returns true if the date is today
  bool get isToday {
    final now = DateTime.now();
    return isSameDay(now);
  }

  /// Checks if the current date is the same as [other]
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Returns a formatted date like "Mon, 11 Jul 2025"
  String get toReadable =>
      '${_weekdayName()}, ${day.toString().padLeft(2, '0')} ${_monthName()} $year';

  /// Returns "Yesterday", "Today", "Tomorrow", or formatted date
  String get humanized {
    final today = DateTime.now();
    if (isSameDay(today)) return 'Today';
    if (isSameDay(today.subtract(const Duration(days: 1)))) return 'Yesterday';
    if (isSameDay(today.add(const Duration(days: 1)))) return 'Tomorrow';
    return toShortDate;
  }

  String _weekdayName() {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[weekday - 1];
  }

  String _monthName() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
