import 'dart:convert';

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

  static Future<String> getHuggingFaceResponse(String ask) async {
    try {
      final url =
          'https://api-inference.huggingface.co/models/Qwen/Qwen2.5-Coder-32B-Instruct/v1/chat/completions';

      final headers = {
        'Authorization': 'Bearer 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',
        'Content-Type': 'application/json'
      };
      final data = {
        "model": "Qwen/Qwen2.5-Coder-32B-Instruct",
        "messages": [
          {"role": "user", "content": ask}
        ],
        "max_tokens": 500,
        "stream": false
      };

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      final text = jsonDecode(utf8.decode(response.body.codeUnits))['choices']
          [0]['message']['content'];

      return text;
    } catch (e) {
      throw Exception(e);
    }
  }
}
