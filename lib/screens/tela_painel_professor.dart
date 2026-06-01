import 'package:flutter/material.dart';
import 'tela_gerenciar_disponibilidade.dart';

class TelaPainelProfessor extends StatelessWidget {
  const TelaPainelProfessor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel do Professor'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Gerenciar Horários',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaGerenciarDisponibilidade(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Card(
            elevation: 3,
            child: ListTile(
              title: const Text('Ana Clara - Engenharia de Software'),
              subtitle: const Text('Segunda-feira, 10:00 - 11:30'),
              trailing: IconButton(
                icon: const Icon(Icons.check_circle, color: Colors.green),
                onPressed: () {
                  final relatorioController = TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Relatório de aula'),
                        content: TextField(
                          controller: relatorioController,
                          decoration: const InputDecoration(
                            labelText: 'O que foi abordado ?',
                          ),
                          maxLines: 5,
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Relatório salvo com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
