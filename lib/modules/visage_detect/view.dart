import 'dart:io';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellibox/modules/apis/ninja.dart';
import 'package:intellibox/modules/visage_detect/model.dart';
import 'package:intellibox/widgets/btns.dart';

class VisageDetectPage extends StatefulWidget {
  const VisageDetectPage({super.key});

  @override
  State<VisageDetectPage> createState() => _VisageDetectPageState();
}

class _VisageDetectPageState extends State<VisageDetectPage> {
  XFile? image;
  List<VisageDetect> detects = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null)
            Expanded(
              child: ImagePaint(
                path: image!.path,
                detects: detects,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: MainButton(
                  text: "Choisir une image",
                  onPressed: () async {
                    // ignore: invalid_use_of_visible_for_testing_member
                    await _getImage();
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (image != null)
                Expanded(
                  child: AsyncButtonBuilder(
                    child: const MainButton(
                      text: 'Detecter',
                    ),
                    onPressed: () async {
                      await Ninja.visageDetect(File(image!.path)).then((value) {
                        setState(() {
                          detects = value ?? [];
                        });
                      });
                    },
                    builder: (context, child, callback, buttonState) {
                      return GestureDetector(
                        onTap: callback,
                        child: child,
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
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
      setState(() {
        image = value;
      });
      return null;
    });
  }
}

class ImagePaint extends StatelessWidget {
  const ImagePaint({super.key, required this.path, required this.detects});
  final String path;
  final List<VisageDetect> detects;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          File(path),
          fit: BoxFit.cover,
        ),
        CustomPaint(
          painter: MyPainter()..ds = detects,
        )
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  Paint pt = Paint();

  List<VisageDetect> ds = [];

  @override
  void paint(Canvas canvas, Size size) {
    pt.color = Colors.blue;
    pt.strokeWidth = 3;
    pt.strokeCap = StrokeCap.round;
    pt.style = PaintingStyle.stroke;

    for (var d in ds) {
      canvas.drawRect(
          Rect.fromCenter(
            center: Offset(d.x.toDouble(), d.y.toDouble()),
            width: d.width.toDouble(),
            height: d.height.toDouble(),
          ),
          pt);

      canvas.drawRect(
          Rect.fromLTWH(d.x.toDouble(), d.y.toDouble(), d.width.toDouble(),
              d.height.toDouble()),
          pt);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return true;
  }
}
