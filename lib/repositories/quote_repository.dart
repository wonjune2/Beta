import 'package:beta/models/quote_model.dart';

class QuoteRepository {
  Future<QuoteModel> fetchQuote() async {
    // 네트워크 딜레이 흉내 (1초)
    await Future.delayed(const Duration(seconds: 1));

    return const QuoteModel(
      content: "성공은 최종적인 것이 아니며, 실패는 치명적인 것이 아니다.\n중요한 것은 계속하고자 하는 용기다.",
      author: "Winston Churchill",
    );
  }
}
