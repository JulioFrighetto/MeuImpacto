import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/footprint_result.dart';

class StorageService {
  static const String _historyKey = 'history';
  static const String _lastScoreKey = 'lastScore';
  static const String _lastFootprintKey = 'lastFootprint';
  static const String _challengePrefix = 'challenge_';

  // Salvar resultado
  Future<void> saveResult(FootprintResult result) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Salvar no histórico
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    history.add(jsonEncode(result.toJson()));
    await prefs.setStringList(_historyKey, history);
    
    // Salvar último resultado
    await prefs.setInt(_lastScoreKey, result.score);
    await prefs.setDouble(_lastFootprintKey, result.footprint);
  }

  // Obter histórico
  Future<List<FootprintResult>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historyStrings = prefs.getStringList(_historyKey) ?? [];
    
    return historyStrings
        .map((s) => FootprintResult.fromJson(jsonDecode(s)))
        .toList()
        .reversed
        .take(10)
        .toList();
  }

  // Obter último resultado
  Future<FootprintResult?> getLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt(_lastScoreKey);
    final footprint = prefs.getDouble(_lastFootprintKey);
    
    if (score == null || footprint == null) return null;
    
    return FootprintResult(
      score: score,
      footprint: footprint,
      date: DateTime.now(),
    );
  }

  // Salvar estado do desafio
  Future<void> saveChallengeState(int index, bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_challengePrefix$index', completed);
  }

  // Obter estado do desafio
  Future<bool> getChallengeState(int index) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_challengePrefix$index') ?? false;
  }

  // Limpar todos os dados
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}