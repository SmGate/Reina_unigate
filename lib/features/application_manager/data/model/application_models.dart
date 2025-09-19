enum AppStatus { draft, awaitingDocs, inReview, accepted, rejected }

extension AppStatusLabel on AppStatus {
  String get label {
    switch (this) {
      case AppStatus.draft:
        return 'Draft';
      case AppStatus.awaitingDocs:
        return 'Awaiting Docs';
      case AppStatus.inReview:
        return 'In Review';
      case AppStatus.accepted:
        return 'Accepted';
      case AppStatus.rejected:
        return 'Rejected';
    }
  }
}

class Task {
  String title;
  bool done;
  Task(this.title, this.done);
}

class ApplicationItem {
  final String university;
  final String country;
  final String program;
  final String deadline;
  final AppStatus status;
  final double progress;
  final List<Task> tasks;
  final String banner;

  ApplicationItem({
    required this.university,
    required this.country,
    required this.program,
    required this.deadline,
    required this.status,
    required this.progress,
    required this.tasks,
    required this.banner,
  });
}
