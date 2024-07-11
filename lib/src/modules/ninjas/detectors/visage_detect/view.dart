import 'dart:io';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellibox/src/modules/apis/ninja.dart';
import 'package:intellibox/src/widgets/btns.dart';

import 'model.dart';

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

// ignore: must_be_immutable
class ImagePaint extends StatelessWidget {
  ImagePaint({super.key, required this.path, required this.detects});
  final String path;
  final List<VisageDetect> detects;
  late Image image;

  @override
  Widget build(BuildContext context) {
    image = Image.file(
      File(path),
      fit: BoxFit.contain,
      width: 350,
      height: 500,
    );

    return CustomPaint(
      foregroundPainter: MyPainter(context)..ds = detects,
      size: const Size(200, 300),
      child: image,
    );
  }
}

class MyPainter extends CustomPainter {
  Paint pt = Paint();

  final BuildContext context;

  List<VisageDetect> ds = [];

  MyPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    pt.color = Colors.blue;
    pt.strokeWidth = 3;
    pt.strokeCap = StrokeCap.round;
    pt.style = PaintingStyle.stroke;

    for (var d in ds) {
      final box = context.findRenderObject() as RenderBox;
      final widgetRect = const Offset(50, 50) & box.size;
      canvas.translate(widgetRect.left, widgetRect.top);

      canvas.drawRect(
          Rect.fromLTWH(0, 0, d.width.toDouble(), d.height.toDouble()), pt);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return true;
  }
}
