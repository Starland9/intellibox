import 'package:flutter/material.dart';
import 'package:intellibox_v2/src/utils/store.dart';
import 'package:translator/translator.dart';

class Nav {
  static push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  static pushR(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => page,
    ));
  }
}

Future<String> tr(String text) async =>
    (await text.translate(to: AppStore.locale)).text;

Uri getEndPoint(String word) =>
    Uri.parse("https://api.api-ninjas.com/v1/$word");
