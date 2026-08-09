import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const Map <String, String> languages = {
    'en': 'English',
    'ja': 'Japanese',
    'zh': 'Chinese',
    'ko': 'Korean',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
  };
  
  Future<String> translate ({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/translate'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'q': text,
        'source': sourceLanguage,
        'target': targetLanguage,
        'format': 'text',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Translation failed: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);

    return data['translatedText'];
  }
}