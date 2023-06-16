import 'dart:typed_data';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:intellibox/modules/apis/hugging_face.dart';
import 'package:intellibox/utils/assets.dart';
import 'package:intellibox/widgets/btns.dart';

class ImageGen1 extends StatefulWidget {
  const ImageGen1({super.key});

  @override
  State<ImageGen1> createState() => _ImageGen1State();
}

class _ImageGen1State extends State<ImageGen1> {
  Uint8List? imageBytes;
  String? error;

  var text = TextEditingController(text: "banana");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (imageBytes != null)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            color: Colors.black,
                            child: _buildImage(),
                          ),
                        );
                      },
                    );
                  },
                  child: _buildImage(),
                ),
              const SizedBox(height: 20),
              if (error != null) _buildError(),
              // const Spacer(),
              _buildSearch(),
            ],
          ),
        ),
      ),
    );
  }

  Image _buildImage() {
    return Image.memory(
      imageBytes!,
      height: 280,
    );
  }

  Widget _buildSearch() {
    return Column(
      children: [
        TextField(
          minLines: 2,
          maxLines: null,
          controller: text,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            filled: true,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  text.clear();
                });
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        AsyncButtonBuilder(
          child: const MainButton(
            text: 'Générer la nouvelle image',
          ),
          onPressed: () async {
            await HuggingFace().generateImage(text.text, null).then((value) {
              setState(() {
                error = null;
              });
              if (value is String || value == null) {
                setState(() {
                  error = value.toString();
                });
              } else {
                setState(() {
                  imageBytes = value as Uint8List;
                });
              }
            });
          },
          builder: (context, child, callback, buttonState) {
            return GestureDetector(
              onTap: callback,
              child: child,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        // MainButton(text: "Télécharger", onPressed: ()async {
        //   var dir  = (await getApplicationDocumentsDirectory()).path;
        // }),
      ],
    );
  }

  Widget _buildError() {
    return Column(
      children: [
        Text(
          error!,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: Image.asset(
            SImages.busyLogo,
          ),
        ),
      ],
    );
  }
}

class ChatImageGen extends StatefulWidget {
  const ChatImageGen({super.key});

  @override
  State<ChatImageGen> createState() => _ChatImageGenState();
}

class _ChatImageGenState extends State<ChatImageGen> {
  List<types.Message> messages = [];

  types.User me = const types.User(id: "0");

  @override
  Widget build(BuildContext context) {
    return Chat(
      theme: const DarkChatTheme(),
      messages: messages,
      onSendPressed: (text) {
        _onSendTextPressed(text);
      },
      user: const types.User(
        id: "0",
      ),
    );
  }

  void _onSendTextPressed(types.PartialText text) {
    setState(() {
      messages.insert(
          0,
          types.TextMessage(
            id: "0",
            author: me,
            text: text.text,
          ));
    });
  }
}
