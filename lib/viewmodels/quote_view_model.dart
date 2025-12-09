import 'package:beta/models/quote_model.dart';
import 'package:beta/repositories/quote_repository.dart';
import 'package:flutter/material.dart';

class QuoteViewModel extends ChangeNotifier {
  final QuoteRepository _repository;

  // 상태 변수들 (State)
  QuoteModel? _quote;
  bool _isLoading = true;

  // 외부에서 상태를 읽을 수 있게 getter 제공
  QuoteModel? get quote => _quote;
  bool get isLoading => _isLoading;

  // 생성자 주입 (Dependency Injection)
  QuoteViewModel({required QuoteRepository repository}) : _repository = repository;

  Future<void> loadQuote() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quote = await _repository.fetchQuote();
    } catch (e) {
      print('에러 발생: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
