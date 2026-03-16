import 'package:flutter/material.dart';
import './screen/feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda IFPR',
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int _paginaAtual = 0;

  final List<Widget> _telas = [
    const AgendaHome(),
    const FeedScreen(),
    const Center(child: Text("Horários de Aula")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_paginaAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: (index) {
          setState(() {
            _paginaAtual = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Agenda",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "Eventos",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Horários",
          ),
        ],
      ),
    );
  }
}

class AgendaHome extends StatefulWidget {
  const AgendaHome({super.key});

  @override
  State<AgendaHome> createState() => _AgendaHomeState();
}

class _AgendaHomeState extends State<AgendaHome> {

  DateTime _dataSelecionada = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Agenda - IFPR'),
        backgroundColor: const Color.fromARGB(255, 101, 168, 223),
        centerTitle: true,
      ),

      body: Column(
        children: [

          CalendarDatePicker(
            initialDate: _dataSelecionada,
            firstDate: DateTime(2024),
            lastDate: DateTime(2030),
            onDateChanged: (date) {
              setState(() {
                _dataSelecionada = date;
              });
            },
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.event_available, size: 40),
                const SizedBox(height: 10),

                Text(
                  'Data: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text('Nenhum compromisso para hoje.')
              ],
            ),
          )
        ],
      ),
    );
  }
}