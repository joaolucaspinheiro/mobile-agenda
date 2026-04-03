import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/calendar_student.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academus - IFPR',
      home: const CalendarStudent(),
    );
  }
}
