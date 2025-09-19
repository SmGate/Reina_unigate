extension ListUtils<T> on List<T> {
  bool get isNullOrEmpty => isEmpty;
  T? get firstOrNull => isEmpty ? null : first;
}
