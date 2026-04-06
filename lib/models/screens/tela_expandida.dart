import 'package:flutter/material.dart';
import 'tela_horarios.dart';

class TelaExpandida extends StatelessWidget {
  // estado fixo e sem mudança..

  final List<Map<String, String>> professores = const [
    {
      'nome': 'Prof. Sérgio Luís',
      'materia': 'Algoritmos I',
      'horario': '19:00 - 21:00',
      'local': 'Sala 15',
    },
    {
      'nome': 'Prof. Ana Maria',
      'materia': 'Estruturas de Dados',
      'horario': '14:00 - 16:00',
      'local': 'Sala 10',
    },
    {
      'nome': 'Prof. Carlos Eduardo',
      'materia': 'Banco de Dados',
      'horario': '16:00 - 18:00',
      'local': 'Sala 20',
    },
  ];
  const TelaExpandida({super.key});
  //trava como tela expandida, super.key é a chave pra ser construído depois

  @override
  Widget build(BuildContext context) {
    //Método pra começar a construir
    return Scaffold(
      //esqueleto da tela.
      appBar: AppBar(
        title: const Text('Tela Expandida'), //titúlo com texto constante.
        backgroundColor: Colors.green,
        foregroundColor: Colors.white, //cor do texto
      ),

      body: ListView.builder(
        //margem interna
        padding: const EdgeInsets.all(20.0), //margem fixa de 20 aos lados
        itemCount: professores.length, //quantos professores tem

        itemBuilder: (context, index) {
          //montador
          final prof = professores[index]; //pega o professor atual

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16), //pra num grudar
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    prof['nome']!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Matéria: ${prof['materia']}',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: Color.fromARGB(255, 79, 79, 79),
                      ),
                      const SizedBox(width: 8),
                      Text(prof['horario']!, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: Color.fromARGB(255, 79, 79, 79),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Local: ${prof['local']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaHorarios(professor: prof),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                      ),
                      child: const Text('Ver Detalhes'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
