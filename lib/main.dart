import 'package:beta/repositories/quote_repository.dart';
import 'package:beta/viewmodels/quote_view_model.dart';
import 'package:beta/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // 1. 앱 시작 전, 필요한 객체들을 미리 생성합니다. (싱글톤처럼 동작)
  final quoteRepository = QuoteRepository();
  final quoteViewModel = QuoteViewModel(repository: quoteRepository);

  // 2. 생성된 ViewModel을 앱에 주입합니다.
  runApp(QuoteApp(viewModel: quoteViewModel));
}

class QuoteApp extends StatelessWidget {
  final QuoteViewModel viewModel;

  const QuoteApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(viewModel: viewModel),
    );
  }
}
