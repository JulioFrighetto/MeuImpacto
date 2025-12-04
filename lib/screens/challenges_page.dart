import 'package:flutter/material.dart';
import '../services/challenge_service.dart';
import '../services/storage_service.dart';
import '../models/challenge.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  late List<Challenge> _challenges;
  final _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _challenges = ChallengeService.getChallenges();
    _loadChallenges();
  }

  Future<void> _loadChallenges() async {
    for (int i = 0; i < _challenges.length; i++) {
      final completed = await _storageService.getChallengeState(i);
      setState(() {
        _challenges[i].completed = completed;
      });
    }
  }

  Future<void> _toggleChallenge(int index) async {
    setState(() {
      _challenges[index].completed = !_challenges[index].completed;
    });
    await _storageService.saveChallengeState(index, _challenges[index].completed);
  }

  @override
  Widget build(BuildContext context) {
    int totalPoints = _challenges
        .where((c) => c.completed)
        .fold(0, (sum, c) => sum + c.points);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafios Sustentáveis'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pontos Totais',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '$totalPoints',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _challenges.length,
              itemBuilder: (context, index) {
                final challenge = _challenges[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: challenge.completed
                          ? Colors.green
                          : Colors.grey[300],
                      child: Icon(
                        challenge.icon,
                        color: challenge.completed
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                    ),
                    title: Text(
                      challenge.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: challenge.completed
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(challenge.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+${challenge.points}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Checkbox(
                          value: challenge.completed,
                          onChanged: (value) => _toggleChallenge(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}