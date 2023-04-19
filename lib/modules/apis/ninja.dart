import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intellibox/.env/keys.dart';
import 'package:intellibox/modules/devinette/model.dart';

class Ninja {
  static Future<Devinette?> getDevinette(int? limit) async {
    try {
      var r = await http
          .get(Uri.parse("https://api.api-ninjas.com/v1/riddles"), headers: {
        if (limit != null) "limit": limit.toString(),
        'X-Api-Key': ApiKeys.ninja,
      });

      return Devinette.fromJson(jsonDecode(r.body)[0]);
    } catch (e) {
      return null;
    }
  }
}
