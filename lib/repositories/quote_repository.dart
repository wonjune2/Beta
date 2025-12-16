import 'dart:convert';

import 'package:beta/models/quote_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuoteRepository {
  // 주의: 실제 배포 시 API 키는 .env 파일 등으로 안전하게 관리해야 합니다.
  // 깃허브에 올릴 때는 꼭 지우고 올리세요!.
  static const String _apiKey = '';

  late final GenerativeModel _model;

  QuoteRepository() {
    // gemini 2.5 Flash 모델 사용
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }

  Future<QuoteModel> fetchQuote() async {
    try {
      final userPrompt = Content.text('사소한 일에 일희일비하지않고 싶어');

      final response = await _model.generateContent([userPrompt]);

      if (response.text == null) {
        throw Exception('Gemini가 빈 응답을 보냈습니다.');
      }

      final dynamic decoded = jsonDecode(response.text!);
      Map<String, dynamic> jsonMap;

      if (decoded is List) {
        if (decoded.isEmpty) throw Exception('빈 데이터입니다.');
        jsonMap = decoded.first as Map<String, dynamic>;
      } else {
        jsonMap = decoded as Map<String, dynamic>;
      }

      return QuoteModel.fromJson(jsonMap);
    } catch (e) {
      print('Gemini API Error: $e');
      throw Exception('명언을 가져오는데 실패했습니다.');
    }
  }
}
