// Create a json serializable class from this data
import 'package:intellibox/src/utils/logic.dart';

class AnObject {
  String? label;
  String? confidence;
  BoundingBox? boundingBox;

  AnObject({this.label, this.confidence, this.boundingBox});

  factory AnObject.fromJson(Map<String, dynamic> json) {
    return AnObject(
      label: json['label'],
      confidence: json['confidence'],
      boundingBox: BoundingBox.fromJson(json['bounding_box']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['confidence'] = confidence;
    data['bounding_box'] = boundingBox?.toJson();
    return data;
  }

  static Future<AnObject> translated(AnObject anObject) async {
    return AnObject(
      label: await tr(anObject.label ?? ""),
      confidence: anObject.confidence,
      boundingBox: BoundingBox(
        x1: anObject.boundingBox?.x1,
        y1: anObject.boundingBox?.y1,
        x2: anObject.boundingBox?.x2,
        y2: anObject.boundingBox?.y2,
      ),
    );
  }
}

// Create a bouncing box json serializable class from this data
class BoundingBox {
  String? x1;
  String? y1;
  String? x2;
  String? y2;

  BoundingBox({this.x1, this.y1, this.x2, this.y2});

  BoundingBox.fromJson(Map<String, dynamic> json) {
    x1 = json['x1'];
    y1 = json['y1'];
    x2 = json['x2'];
    y2 = json['y2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x1'] = x1;
    data['y1'] = y1;
    data['x2'] = x2;
    data['y2'] = y2;
    return data;
  }
}
