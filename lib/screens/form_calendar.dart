import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormCalendar extends StatelessWidget {
  const FormCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre seu evento'),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
      ),
    );
  }
}
