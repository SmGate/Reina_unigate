class ChatMessage {
  final bool fromBot; // true => bot/advisor, false => user
  final String text;
  final DateTime time;

  ChatMessage({
    required this.fromBot,
    required this.text,
    required this.time,
  });
}

class FaqItem {
  final String title;
  final String body;
  const FaqItem(this.title, this.body);
}
