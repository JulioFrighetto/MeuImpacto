import 'package:flutter/material.dart';
import 'quiz_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pegada Ecológica'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.eco, size: 60, color: Colors.green),
                    const SizedBox(height: 16),
                    const Text(
                      'Bem-vindo!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Descubra seu impacto no planeta',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QuizPage()),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Iniciar Questionário'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Dicas Rápidas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTipCard('Transporte', 'Use transporte público ou bicicleta', Icons.directions_bike),
            _buildTipCard('Alimentação', 'Reduza o consumo de carne', Icons.restaurant),
            _buildTipCard('Energia', 'Desligue aparelhos em standby', Icons.power),
            _buildTipCard('Reciclagem', 'Separe seu lixo corretamente', Icons.recycling),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(String title, String tip, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: Icon(icon, color: Colors.green),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tip),
      ),
    );
  }
}