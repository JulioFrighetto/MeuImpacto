import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../models/footprint_result.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FootprintResult? _lastResult;
  List<FootprintResult> _history = [];
  final _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final lastResult = await _storageService.getLastResult();
    final history = await _storageService.getHistory();
    
    setState(() {
      _lastResult = lastResult;
      _history = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
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
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Perfil Ambiental',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    if (_lastResult != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Última Pontuação: ${_lastResult!.score}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Pegada: ${_lastResult!.footprint.toStringAsFixed(1)} ton CO₂/ano',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ] else
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Faça o questionário para ver seu perfil'),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Histórico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (_history.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Nenhum histórico ainda'),
                ),
              )
            else
              ..._history.map((result) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.green),
                    title: Text(
                      '${result.date.day}/${result.date.month}/${result.date.year}'
                    ),
                    subtitle: Text(
                      'Pontos: ${result.score} | ${result.footprint.toStringAsFixed(1)} ton CO₂',
                    ),
                  ),
                );
              }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await _storageService.clearAllData();
                  setState(() {
                    _lastResult = null;
                    _history = [];
                  });
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dados limpos com sucesso')),
                  );
                },
                icon: const Icon(Icons.delete),
                label: const Text('Limpar Dados'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}