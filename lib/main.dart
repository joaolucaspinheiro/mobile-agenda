import 'package:flutter/material.dart';
import 'package:test_application/models/screens/tela_dashboard_aluno.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TelaDashboardAluno(),
    );
  }
}
