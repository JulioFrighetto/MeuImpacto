import '../models/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeService {
  static List<Challenge> getChallenges() {
    return [
      Challenge(
        title: 'Semana sem Carne',
        description: 'Evite carne por 7 dias',
        points: 50,
        icon: Icons.restaurant,
      ),
      Challenge(
        title: 'Zero Plástico',
        description: 'Não use plástico descartável por 5 dias',
        points: 40,
        icon: Icons.no_drinks,
      ),
      Challenge(
        title: 'Mobilidade Verde',
        description: 'Use apenas transporte sustentável por 1 semana',
        points: 60,
        icon: Icons.directions_bike,
      ),
      Challenge(
        title: 'Economia de Água',
        description: 'Banhos de no máximo 5 minutos por 1 semana',
        points: 30,
        icon: Icons.water_drop,
      ),
      Challenge(
        title: 'Reciclagem Total',
        description: 'Separe todo o lixo por 1 semana',
        points: 35,
        icon: Icons.recycling,
      ),
    ];
  }
}
