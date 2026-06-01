import 'package:flutter/material.dart';
import 'package:test_application/screens/tela_cursos.dart';
import 'package:test_application/screens/tela_detalhes_agendamentos.dart';

class TelaDashboardAluno extends StatelessWidget {
  const TelaDashboardAluno({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central do Aluno'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Próximos atendimentos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10),

          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.event, size: 30, color: Colors.green),
              title: const Text(
                'Engenharia de Software',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Segunda-feira, 19:00 - 21:00\nProfessor: Dr. Silva',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.cancel, size: 16, color: Colors.red),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaDetalhesAgendamento(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Histórico',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            color: Colors.grey.shade100,
            elevation: 1,
            child: ListTile(
              leading: const Icon(Icons.history, size: 30, color: Colors.green),
              title: const Text(
                'Banco de Dados',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Quarta-feira, 14:00 - 16:00\nProfessor: Dr. Oliveira',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TelaCursos()),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Novo Agendamento'),
      ),
    );
  }
}
