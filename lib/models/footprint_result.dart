import 'package:flutter/material.dart';

class FootprintResult {
  final int score;
  final double footprint;
  final DateTime date;

  FootprintResult({
    required this.score,
    required this.footprint,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'footprint': footprint,
      'date': date.toIso8601String(),
    };
  }

  factory FootprintResult.fromJson(Map<String, dynamic> json) {
    return FootprintResult(
      score: json['score'],
      footprint: json['footprint'],
      date: DateTime.parse(json['date']),
    );
  }

  String getLevel() {
    if (score < 10) return 'Precisa Melhorar';
    if (score < 20) return 'Médio';
    if (score < 30) return 'Bom';
    return 'Excelente';
  }

  Color getLevelColor() {
    if (score < 10) return Colors.red;
    if (score < 20) return Colors.orange;
    if (score < 30) return Colors.lightGreen;
    return Colors.green;
  }
}