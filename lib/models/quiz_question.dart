class QuizQuestion {
  final String category;
  final String question;
  final List<QuizOption> options;

  QuizQuestion({
    required this.category,
    required this.question,
    required this.options,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'question': question,
      'options': options.map((o) => o.toJson()).toList(),
    };
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      category: json['category'],
      question: json['question'],
      options: (json['options'] as List)
          .map((o) => QuizOption.fromJson(o))
          .toList(),
    );
  }
}

class QuizOption {
  final String text;
  final int value;

  QuizOption({required this.text, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'value': value,
    };
  }

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      text: json['text'],
      value: json['value'],
    );
  }
}