import 'package:beta/repositories/quote_repository.dart';
import 'package:beta/viewmodels/quote_view_model.dart';
import 'package:beta/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class QuoteApp extends StatelessWidget {
  // Repository 생성
  final quoteRepository = QuoteRepository();
  // ViewModel 생성 (Repo 주입)
  final quoteViewModel = QuoteViewModel(repository: quoteRepository);

  QuoteApp({super.key});

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
