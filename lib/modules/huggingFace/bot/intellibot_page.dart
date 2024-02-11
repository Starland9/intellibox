import 'package:flutter/material.dart';
import 'package:intellibox/modules/apis/gpt.dart';
import 'package:intellibox/modules/huggingFace/bot/widgets/message_card.dart';

import '../../../models/bot_message.dart';

final List<BotMessage> messages = [];

class IntelliBotPage extends StatefulWidget {
  const IntelliBotPage({super.key});

  @override
  State<IntelliBotPage> createState() => _IntelliBotPageState();
}

class _IntelliBotPageState extends State<IntelliBotPage> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  bool _gptWrintig = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      _jumpToBottom();
    });
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ...messages.map((e) => MessageCard(message: e)),
                ...[
                  if (_gptWrintig)
                    MessageCard(
                      message: BotMessage(
                        isMeASender: false,
                        text: "...",
                      ),
                      iswriting: true,
                    ),
                  const SizedBox(height: 32)
                ]
              ],
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration.collapsed(
                  hintText: "Entre ton message",
                ),
                minLines: 1,
                maxLines: 5,
                contentInsertionConfiguration: ContentInsertionConfiguration(
                    onContentInserted: _onContentInserted),
              ),
            ),
            IconButton.filledTonal(
              onPressed: () => _sendMessage(true, _messageController.text),
              icon: const Icon(Icons.send_outlined),
            )
          ],
        )
      ],
    );
  }

  void _sendMessage(bool isMe, String text) {
    if (text.isEmpty) {
      return;
    }
    setState(() {
      messages.add(
        BotMessage(isMeASender: isMe, text: text),
      );
      _messageController.clear();
      if (isMe) {
        _getGptResponse(text);
      }
    });
    _jumpToBottom();
  }

  void _getGptResponse(String text) {
    _jumpToBottom();
    String rep =
        "Voici l'historique de notre conversation : \n${_getConversation()}\n";
    rep += "Maintenant voici mon prochain message : '$text'. reponds moi";

    setState(() {
      _gptWrintig = true;
    });
    GPT.getResponse(rep).then((value) {
      setState(() {
        _gptWrintig = false;
      });
      _sendMessage(false, value);
    }).onError((error, stackTrace) {
      setState(() {
        _gptWrintig = false;
      });
      _sendMessage(false, error.toString());
    });
    _jumpToBottom();
  }

  String _getConversation() {
    String text = "";
    for (var message in messages) {
      text += message.toGpt();
    }
    return text;
  }

  void _jumpToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _onContentInserted(KeyboardInsertedContent value) {
    if (!value.hasData) {
      return;
    }
    if (value.mimeType.contains("image")) {
      showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (context) => Image.memory(value.data!),
      );
    }
  }
}
