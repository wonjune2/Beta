import 'package:beta/viewmodels/quote_view_model.dart';
import 'package:beta/views/widgets/quote_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final QuoteViewModel viewModel;
  const HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder: ViewModel의 notifyListeners()가 호출되면 builder가 다시 실행됨
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Beta'), centerTitle: true),
          body: Center(
            child: widget.viewModel.isLoading
                ? const CircularProgressIndicator()
                : widget.viewModel.quote == null
                ? const Text('버튼을 눌러 명언을 생성해보세요!')
                : QuoteCard(quote: widget.viewModel.quote!),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: widget.viewModel.isLoading ? null : () => widget.viewModel.loadQuote(),
            label: const Text('명언 생성'),
            icon: const Icon(Icons.auto_awesome),
          ),
        );
      },
    );
  }
}
