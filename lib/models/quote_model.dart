class QuoteModel {
  final String mentorQuote;
  final String personInfo;
  final String insight;
  final String actionQuestion;

  QuoteModel({
    required this.mentorQuote,
    required this.personInfo,
    required this.insight,
    required this.actionQuestion,
  });

  // JSON 데이터로부터 객체를 생성하는 팩토리 생성자
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      mentorQuote: json['mentor_quote'] ?? '',
      personInfo: json['person_info'] ?? '',
      insight: json['insight'] ?? '',
      actionQuestion: json['action_question'] ?? '',
    );
  }
}
