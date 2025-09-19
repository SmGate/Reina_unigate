enum DocStatus { missing, draft, uploading, uploaded }

class DocItem {
  final String type;
  final DocStatus status;
  final String size;

  DocItem({required this.type, required this.status, required this.size});
}

class StatusStyle {
  final String label;
  final int fg; // ARGB hex via Color value
  final int bg;
  final String iconName; // optional if you want to store icon id elsewhere

  const StatusStyle({
    required this.label,
    required this.fg,
    required this.bg,
    required this.iconName,
  });
}
