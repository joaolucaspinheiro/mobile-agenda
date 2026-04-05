import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import 'event_detail.dart';
class EventList extends StatelessWidget {
  EventList({super.key, required this.events});
  final List<CalendarEvent> events;

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text('Todos seus eventos',
      style: TextStyle(
      color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold
    ),
    ),
      backgroundColor: Colors.green.shade400,
      centerTitle: true,
    ),
      body: ListView.builder(itemCount: events.length, itemBuilder: (context, index){
        final event = events[index];
        return ListTile(
          leading: Icon(Icons.event, color: Colors.green.shade400),
            title: Text(event.title),
          subtitle: Text(event.type.label),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetail(event: event)),
              );
            },
        );
      },
      ),
    );
  }

}