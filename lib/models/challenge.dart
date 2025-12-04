import 'package:flutter/material.dart';

class Challenge {
  final String title;
  final String description;
  final int points;
  final IconData icon;
  bool completed;

  Challenge({
    required this.title,
    required this.description,
    required this.points,
    required this.icon,
    this.completed = false,
  });
}