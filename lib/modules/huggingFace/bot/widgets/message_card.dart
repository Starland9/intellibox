import 'package:flutter/material.dart';
import 'package:intellibox/models/bot_message.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
  });

  final BotMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isMeASender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.8,
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: message.isMeASender ? Colors.blue : Colors.pink.shade900,
          ),
          child: Text(message.text),
        ),
      ),
    );
  }
}
