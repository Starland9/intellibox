import 'dart:io';

import 'package:advance_animated_progress_indicator/advance_animated_progress_indicator.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intellibox/modules/apis/ninja.dart';
import 'package:intellibox/widgets/btns.dart';

import '../../../../utils/theme.dart';
import '../visage_detect/model.dart';
import 'model.dart';


class ObjectDetect extends StatefulWidget {
  const ObjectDetect({super.key});

  @override
  State<ObjectDetect> createState() => _ObjectDetectState();
}

class _ObjectDetectState extends State<ObjectDetect> {
  XFile? image;
  List<AnObject> detects = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null)
            Expanded(
              child: Image.file(
                File(
                  image!.path,
                ),
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
                      setState(() {
                        detects.clear();
                      });
                    });
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
                      await Ninja.objectDetect(File(image!.path)).then((value) {
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
          const SizedBox(height: 25),
          if (detects.isNotEmpty)
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: detects.length,
              itemBuilder: (context, index) {
                AnObject o = detects[index];

                return _buildProgress(o.label ?? "",
                    (double.tryParse(o.confidence ?? "0") ?? 0.0) * 100);
              },
            ))
        ],
      ),
    );
  }

  AnimatedLinearProgressIndicator _buildProgress(String title, double percent) {
    Color c = Scolors.primary;

    percent < 30
        ? c = Colors.blue
        : percent < 60 && percent >= 30
            ? c = Colors.orange
            : c = Colors.green;
    return AnimatedLinearProgressIndicator(
      labelStyle: TextStyle(
        color: c,
      ),
      percentageTextStyle: TextStyle(color: c),
      indicatorColor: c,
      indicatorBackgroundColor: Scolors.primary.withOpacity(0.2),
      percentage: percent / 100,
      label: title,
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
    );

    return CustomPaint(
      // foregroundPainter: MyPainter(context)..ds = detects,
      // size: const Size(200, 300),
      child: image,
    );
  }
}

// class MyPainter extends CustomPainter {
//   Paint pt = Paint();

//   final BuildContext context;

//   List<VisageDetect> ds = [];

//   MyPainter(this.context);

//   @override
//   void paint(Canvas canvas, Size size) {
//     pt.color = Colors.blue;
//     pt.strokeWidth = 3;
//     pt.strokeCap = StrokeCap.round;
//     pt.style = PaintingStyle.stroke;

//     for (var d in ds) {
//       final box = context.findRenderObject() as RenderBox;
//       final widgetRect = const Offset(50, 50) & box.size;
//       canvas.translate(widgetRect.left, widgetRect.top);

//       canvas.drawRect(
//           Rect.fromLTWH(0, 0, d.width.toDouble(), d.height.toDouble()), pt);
//     }
//   }

//   @override
//   bool shouldRepaint(MyPainter oldDelegate) {
//     return true;
//   }
// }
