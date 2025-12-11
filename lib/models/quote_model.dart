class QuoteModel {
  final String content;
  final String author;

  const QuoteModel({required this.content, required this.author});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(content: json['content'] ?? '내용 없음', author: json['author'] ?? 'Unknown');
  }
}
