import 'package:beta/models/quote_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuoteRepository {
  // 주의: 실제 배포 시 API 키는 .env 파일 등으로 안전하게 관리해야 합니다.
  // 깃허브에 올릴 때는 꼭 지우고 올리세요!.
  static const String _apiKey = 'YOUR_API_KEY_HERE';

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
    // 네트워크 딜레이 흉내 (1초)
    await Future.delayed(const Duration(seconds: 1));

    return const QuoteModel(
      content: "성공은 최종적인 것이 아니며, 실패는 치명적인 것이 아니다.\n중요한 것은 계속하고자 하는 용기다.",
      author: "Winston Churchill",
    );
  }
}
