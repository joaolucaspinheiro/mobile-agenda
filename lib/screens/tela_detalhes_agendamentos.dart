import 'package:flutter/material.dart';

class TelaDetalhesAgendamento extends StatelessWidget {
  const TelaDetalhesAgendamento({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Agendamento'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.event_available,
                    size: 60,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    'Engenharia de Software',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1, indent: 20, endIndent: 20),

                  const ListTile(
                    leading: Icon(Icons.person, size: 30, color: Colors.grey),
                    title: Text(
                      'Data e Horário',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Segunda-feira, 19:00 - 21:00'),
                    isThreeLine: true,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.grey,
                    ),
                    title: Text(
                      'Local: ',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Sala 10, Bloco 1'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade400,
                elevation: 0,
              ),
              icon: const Icon(Icons.cancel_outlined, size: 20),
              label: const Text(
                'Cancelar Agendamento',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Agendamento cancelado')),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
