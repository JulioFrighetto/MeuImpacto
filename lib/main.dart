import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const EcoFootprintApp());
}

class EcoFootprintApp extends StatelessWidget {
  const EcoFootprintApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pegada Ecológica',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}