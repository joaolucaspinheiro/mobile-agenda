import 'package:flutter/material.dart';
import 'tela_expandida.dart';

class TelaCursos extends StatelessWidget {
  const TelaCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Curso'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Card(
            elevation: 4,
            child: ListTile(
              leading: const Icon(
                Icons.computer,
                color: Colors.green,
                size: 30,
              ),
              title: const Text(
                'Engenharia de Software',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaExpandida(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
