class BotMessage {
  final bool isMeASender;
  final String text;

  BotMessage({required this.isMeASender, required this.text});

  String toGpt() {
    return "${isMeASender ? "Moi" : "toi"}: $text\n";
  }

  @override
  String toString() {
    return 'BotMessage(isMeASender: $isMeASender, text: $text)';
  }
}
