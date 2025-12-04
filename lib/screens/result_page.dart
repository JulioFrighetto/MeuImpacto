import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/footprint_result.dart';
import '../services/quiz_service.dart';
import 'home_page.dart';

class ResultPage extends StatelessWidget {
  final FootprintResult result;
  final Map<String, dynamic> answers;

  const ResultPage({
    Key? key,
    required this.result,
    required this.answers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tips = QuizService.generateTips(answers);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.eco, size: 80, color: result.getLevelColor()),
                    const SizedBox(height: 16),
                    Text(
                      result.getLevel(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: result.getLevelColor(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sua Pegada Ecológica',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: result.getLevelColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${result.footprint.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: result.getLevelColor(),
                            ),
                          ),
                          const Text(
                            'toneladas CO₂/ano',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Pontuação: ${result.score} pontos',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Dicas Personalizadas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            ...tips.map((tip) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.lightbulb, color: Colors.amber),
                title: Text(tip),
              ),
            )),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Share.share(
                        'Minha pegada ecológica é de ${result.footprint.toStringAsFixed(1)} toneladas de CO₂/ano! '
                        'Nível: ${result.getLevel()}. Calcule a sua no app Pegada Ecológica! 🌍',
                      );
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Compartilhar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('Início'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}