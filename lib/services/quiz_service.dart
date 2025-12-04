import '../models/quiz_question.dart';

class QuizService {
  static List<QuizQuestion> getQuestions() {
    return [
      QuizQuestion(
        category: 'Transporte',
        question: 'Como você vai ao trabalho/escola?',
        options: [
          QuizOption(text: 'Carro próprio', value: 4),
          QuizOption(text: 'Transporte público', value: 2),
          QuizOption(text: 'Bicicleta/A pé', value: 0),
          QuizOption(text: 'Carona compartilhada', value: 1),
        ],
      ),
      QuizQuestion(
        category: 'Transporte',
        question: 'Quantos km você percorre por semana?',
        options: [
          QuizOption(text: 'Menos de 50 km', value: 1),
          QuizOption(text: '50-150 km', value: 2),
          QuizOption(text: '150-300 km', value: 3),
          QuizOption(text: 'Mais de 300 km', value: 5),
        ],
      ),
      QuizQuestion(
        category: 'Alimentação',
        question: 'Quantas vezes por semana você come carne?',
        options: [
          QuizOption(text: 'Diariamente', value: 5),
          QuizOption(text: '4-6 vezes', value: 3),
          QuizOption(text: '1-3 vezes', value: 1),
          QuizOption(text: 'Não como carne', value: 0),
        ],
      ),
      QuizQuestion(
        category: 'Alimentação',
        question: 'Você compra produtos orgânicos/locais?',
        options: [
          QuizOption(text: 'Sempre', value: 0),
          QuizOption(text: 'Frequentemente', value: 1),
          QuizOption(text: 'Raramente', value: 2),
          QuizOption(text: 'Nunca', value: 3),
        ],
      ),
      QuizQuestion(
        category: 'Consumo',
        question: 'Com que frequência compra roupas novas?',
        options: [
          QuizOption(text: 'Semanalmente', value: 5),
          QuizOption(text: 'Mensalmente', value: 3),
          QuizOption(text: 'A cada 3-6 meses', value: 1),
          QuizOption(text: 'Raramente', value: 0),
        ],
      ),
      QuizQuestion(
        category: 'Energia',
        question: 'Você deixa aparelhos em standby?',
        options: [
          QuizOption(text: 'Sempre', value: 3),
          QuizOption(text: 'Frequentemente', value: 2),
          QuizOption(text: 'Raramente', value: 1),
          QuizOption(text: 'Nunca', value: 0),
        ],
      ),
      QuizQuestion(
        category: 'Resíduos',
        question: 'Você recicla seu lixo?',
        options: [
          QuizOption(text: 'Sempre', value: 0),
          QuizOption(text: 'Frequentemente', value: 1),
          QuizOption(text: 'Raramente', value: 3),
          QuizOption(text: 'Nunca', value: 5),
        ],
      ),
      QuizQuestion(
        category: 'Água',
        question: 'Tempo médio do seu banho?',
        options: [
          QuizOption(text: 'Menos de 5 min', value: 0),
          QuizOption(text: '5-10 min', value: 1),
          QuizOption(text: '10-15 min', value: 2),
          QuizOption(text: 'Mais de 15 min', value: 4),
        ],
      ),
    ];
  }

  static double calculateFootprint(int totalScore) {
    return totalScore * 0.5;
  }

  static List<String> generateTips(Map<String, dynamic> answers) {
    List<String> tips = [];
    
    if ((answers['Transporte'] ?? 0) > 5) {
      tips.add('🚴 Use mais transporte público ou bicicleta');
      tips.add('🚗 Considere carona compartilhada');
    }
    
    if ((answers['Alimentação'] ?? 0) > 5) {
      tips.add('🥗 Reduza o consumo de carne vermelha');
      tips.add('🌱 Prefira alimentos orgânicos e locais');
    }
    
    if ((answers['Energia'] ?? 0) > 3) {
      tips.add('💡 Desligue aparelhos da tomada');
      tips.add('🔌 Use lâmpadas LED');
    }
    
    if ((answers['Resíduos'] ?? 0) > 3) {
      tips.add('♻️ Separe seu lixo para reciclagem');
      tips.add('🛍️ Evite produtos descartáveis');
    }

    if (tips.isEmpty) {
      tips.add('🌟 Continue com seus hábitos sustentáveis!');
      tips.add('📢 Compartilhe suas práticas com amigos');
    }

    return tips;
  }
}