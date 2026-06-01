import 'package:flutter/material.dart';
import 'package:test_application/screens/tela_dashboard_aluno.dart';

import 'tela_painel_professor.dart';

class TelaEscolherPerfil extends StatelessWidget {
  const TelaEscolherPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.green),
              const SizedBox(height: 10),

              const Text(
                'Bem vindo ao nosso sistema !!\nComo você deseja acessar o sistema ?',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              //do aluno
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    elevation: 2,
                    side: const BorderSide(color: Colors.green, width: 1),
                  ),
                  icon: const Icon(Icons.person, size: 28),
                  label: const Text(
                    'Entrar como aluno',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaDashboardAluno(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              //do profe
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.co_present, size: 28),
                  label: const Text(
                    'Entrar como Professor',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaPainelProfessor(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
