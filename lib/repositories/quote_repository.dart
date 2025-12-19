import 'package:beta/models/quote_model.dart';
import 'package:beta/services/gemini_service.dart';

class QuoteRepository {
  Future<QuoteModel?> fetchQuote() async {
    try {
      GeminiService service = GeminiService();
      var result = await service.generateContent("랜덤으로 하나 보내줘");
      return result!;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
