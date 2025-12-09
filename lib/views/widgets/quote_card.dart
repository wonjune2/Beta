import 'package:beta/models/quote_model.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final QuoteModel quote;
  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.format_quote, size: 48, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              quote.content,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, height: 1.4),
            ),
            const SizedBox(height: 24),
            Text(
              '- ${quote.author} -',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
