import 'package:flutter/material.dart';
import 'package:intellibox_v2/src/utils/theme.dart';

class WidgetUtils {
  static Widget buildProgress(
    String title,
    double percent,
  ) {
    Color c = Scolors.primary;

    percent < 30
        ? c = Colors.red
        : percent < 60 && percent >= 30
            ? c = Colors.blue
            : c = Colors.green;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: percent / 100,
                color: c,
                semanticsValue: percent.toString(),
              ),
            ),
            Text(" $percent"),
          ],
        ),
        Text(title),
        SizedBox(height: 12),
      ],
    );
  }
}
