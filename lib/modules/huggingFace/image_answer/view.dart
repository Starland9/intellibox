import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellibox/modules/apis/hugging_face.dart';
import 'package:intellibox/widgets/btns.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ImageAnswer extends StatefulWidget {
  const ImageAnswer({super.key});

  @override
  State<ImageAnswer> createState() => _ImageAnswerState();
}

class _ImageAnswerState extends State<ImageAnswer> {
  XFile? image;

  String? response;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null)
              Expanded(
                child: Image.file(
                  File(image!.path),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    text: "Choisir une image",
                    onPressed: () async {
                      // ignore: invalid_use_of_visible_for_testing_member
                      await _getImage().then((value) {
                        setState(() {});
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            if (response != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                child: Text(
                  response!,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    await ImagePicker.platform
        .getImageFromSource(
      source: ImageSource.gallery,
    )
        .then((value) {
      context.loaderOverlay.show();
      setState(() {
        image = value;
        HuggingFace.answerImage(File(image!.path), "")?.then((value) {
          context.loaderOverlay.hide();
          setState(() {
            response = value;
          });
        });
      });
      return null;
    });
  }
}

// ignore: must_be_immutable
class ImagePaint extends StatelessWidget {
  ImagePaint({super.key, required this.path});
  final String path;
  late Image image;

  @override
  Widget build(BuildContext context) {
    image = Image.file(
      File(path),
      fit: BoxFit.contain,
    );

    return image;
  }
}
