import 'package:flutter/material.dart';
import '../services/quiz_service.dart';
import '../services/storage_service.dart';
import '../models/footprint_result.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestion = 0;
  Map<String, dynamic> _answers = {};
  final _questions = QuizService.getQuestions();
  final _storageService = StorageService();

  void _answerQuestion(int value) {
    setState(() {
      final category = _questions[_currentQuestion].category;
      _answers[category] = (_answers[category] ?? 0) + value;
      
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        _calculateResult();
      }
    });
  }

  void _calculateResult() async {
    int totalScore = 0;
    _answers.forEach((key, value) {
      totalScore += value as int;
    });

    double footprint = QuizService.calculateFootprint(totalScore);

    final result = FootprintResult(
      score: 34 - totalScore,
      footprint: footprint,
      date: DateTime.now(),
    );

    await _storageService.saveResult(result);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          result: result,
          answers: _answers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestion];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestion + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 24),
            Text(
              'Pergunta ${_currentQuestion + 1} de ${_questions.length}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(question.category),
              backgroundColor: Colors.green[100],
            ),
            const SizedBox(height: 16),
            Text(
              question.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final option = question.options[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(option.text),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _answerQuestion(option.value),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}