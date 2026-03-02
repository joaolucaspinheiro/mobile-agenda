import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda IFPR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AgendaHome(),
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
        backgroundColor: Colors.blue[200],
        centerTitle: true,
      ),
      body: SingleChildScrollView( 
        child: Column(
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Icon(Icons.event_available, size: 40, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    'Data: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text('Nenhum compromisso para hoje.'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}