import 'package:http/http.dart' as http;

class GPT {
  static Future<String> getResponse(String ask) async {
    try {
      final response =
          await http.get(Uri.parse("http://62.72.6.182:6699/gpt?ask=$ask"));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Request failed with status code ${response.statusCode}';
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
