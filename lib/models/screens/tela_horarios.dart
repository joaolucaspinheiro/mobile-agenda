import 'package:flutter/material.dart';

class TelaHorarios extends StatelessWidget {
  final Map<String, String> professor;

  const TelaHorarios({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    final List<String> horariosDisponiveis = [
      'Segunda-feira: 19:00 - 21:00',
      'Quarta-feira: 14:00 - 16:00',
      'Sexta-feira: 16:00 - 18:00',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecolha um horário'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: horariosDisponiveis.length,
        itemBuilder: (context, index) {
          final horario = horariosDisponiveis[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_month,
                color: Colors.green,
                size: 30,
              ),

              title: Text(
                horario,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),

              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Você selecionou: $horario do ${professor['nome']}',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
