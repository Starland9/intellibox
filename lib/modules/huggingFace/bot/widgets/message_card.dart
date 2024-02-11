import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gif_view/gif_view.dart';
import 'package:intellibox/models/bot_message.dart';
import 'package:intellibox/utils/assets.dart';
import 'package:markdown/markdown.dart' as md;

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.message,
    this.iswriting = false,
  });

  final BotMessage message;
  final bool iswriting;

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
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 8,
            bottom: 8,
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: message.isMeASender ? Colors.blue : Colors.pink.shade900,
          ),
          child: iswriting
              ? GifView.asset(
                  SImages.writingGif,
                  height: 25,
                  color: Colors.white,
                )
              : Column(
                  crossAxisAlignment: message.isMeASender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    MarkdownBody(
                      data: message.text,
                      selectable: true,
                      extensionSet: md.ExtensionSet(
                        md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                        <md.InlineSyntax>[
                          md.EmojiSyntax(),
                          md.CodeSyntax(),
                          md.LinkSyntax(),
                          md.ImageSyntax(),
                          ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                        ],
                      ),
                    ),
                    // if (!message.isMeASender)
                    // ButtonBar(
                    //   buttonPadding: EdgeInsets.zero,
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     IconButton.outlined(
                    //       style:
                    //           IconButton.styleFrom(padding: EdgeInsets.zero),
                    //       onPressed: _sayText,
                    //       icon: const Icon(Icons.volume_up),
                    //       constraints:
                    //           const BoxConstraints(), // Remove constraints
                    //     )
                    //   ],
                    // ),
                  ],
                ),
        ),
      ),
    );
  }

  void _sayText() {
    FlutterTts().speak(message.text);
  }
}
