import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';

class EventDetail extends StatelessWidget{
  final CalendarEvent event;
  EventDetail({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: 'Detalhes',
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Título', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.black54)),
              Text(event.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              Text('Tipo', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.black54)),
              Text(event.type.label, style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 16.0),
              Text('Descrição', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.black54)),
              Text(event.description ?? 'Sem descrição', style: TextStyle(fontSize: 16.0)),
              Text('Data', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.black54)),
              Text('${event.date.day}/${event.date.month}/${event.date.year}', style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 16.0)

            ],
          ),
        )
    );

  }
}
