import 'package:flutter/material.dart';

class TelaGerenciarDisponibilidade extends StatefulWidget {
  const TelaGerenciarDisponibilidade({super.key});

  @override
  State<TelaGerenciarDisponibilidade> createState() =>
      _TelaGerenciarDisponibilidadeState();
}

class _TelaGerenciarDisponibilidadeState
    extends State<TelaGerenciarDisponibilidade> {
  //ISSO faz o estado da tela

  bool _horario1Ativo = true;
  bool _horario2Ativo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Horários'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Controle de disponibilidade',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 15),

          // Card para o primeiro horário
          Card(
            elevation: 3,
            child: SwitchListTile(
              title: const Text('Segunda-feira, 16:00 - 17:30'),
              subtitle: const Text('Engenharia de Software'),
              activeColor: Colors.green,
              value: _horario1Ativo,

              //profe clicou no botão, o valor do switch muda e a tela é atualizada
              onChanged: (bool diferente) {
                setState(() {
                  _horario1Ativo = diferente;
                });
              },
            ),
          ),

          const SizedBox(height: 10),

          // Card para o segundo horário
          Card(
            color: _horario2Ativo ? Colors.white : Colors.grey[200],
            elevation: 2,
            child: SwitchListTile(
              title: Text(
                'Terça-feira, 14:00 - 15:30',
                style: TextStyle(
                  color: _horario2Ativo ? Colors.black : Colors.grey,
                ),
              ),
              subtitle: const Text('Programação Orientada a Objetos'),

              activeColor: Colors.green,
              value: _horario2Ativo,
              onChanged: (bool diferente) {
                setState(() {
                  _horario2Ativo = diferente;
                });
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Ação para adicionar um novo horário
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Abrindo novo horário')));
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar Horário'),
      ),
    );
  }
}
