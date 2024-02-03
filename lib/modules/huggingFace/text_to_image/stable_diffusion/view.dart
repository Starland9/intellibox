import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intellibox/modules/apis/hugging_face.dart';
import 'package:intellibox/utils/assets.dart';

class ImageGen1 extends StatefulWidget {
  const ImageGen1({super.key});

  @override
  State<ImageGen1> createState() => _ImageGen1State();
}

class _ImageGen1State extends State<ImageGen1> {
  Uint8List? imageBytes;
  String? error;

  final text = TextEditingController(text: "banana");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearch(),
            const SizedBox(height: 16),

            if (imageBytes != null) _buildImageClickable(context),
            if (error != null) _buildError(),
            const SizedBox(height: 16),
            if (imageBytes != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filledTonal(
                    onPressed: _saveImage,
                    icon: const Icon(Icons.download),
                  )
                ],
              )
            // const Spacer(),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildImageClickable(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Widget _buildImage() {
    return FadeInUp(
      child: SlideInUp(
        child: Hero(
          tag: "img",
          child: Image.memory(
            imageBytes!,
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            _buildSearchTextField(),
            _buildGenerateButton(),
          ],
        ),
      ],
    );
  }

  TextField _buildSearchTextField() {
    return TextField(
      minLines: 3,
      maxLines: 5,
      controller: text,
      style: const TextStyle(color: Colors.white),
    );
  }

  AsyncButtonBuilder _buildGenerateButton() {
    return AsyncButtonBuilder(
      child: const Icon(
        Icons.generating_tokens,
        color: Colors.white,
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
        return IconButton.filledTonal(
          onPressed: callback,
          icon: SizedBox(width: 28, height: 28, child: child),
        );
      },
    );
  }

  Widget _buildError() {
    return Column(
      children: [
        Text(
          error!,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Image.asset(SImages.busyLogo),
        ),
      ],
    );
  }

  void _saveImage() async {
    final fileName =
        'intellibox_image_gen${DateTime.now().millisecondsSinceEpoch}';
    ImageGallerySaver.saveImage(imageBytes!, quality: 100, name: fileName);
    Fluttertoast.showToast(msg: "Image saved to gallery as $fileName");
  }
}
