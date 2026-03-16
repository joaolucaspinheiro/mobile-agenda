import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/event_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<CalendarEvent> eventos = [
      CalendarEvent(
        id: "1",
        title: "Semana Acadêmica",
        description: "Palestras e workshops com profissionais da área.",
        date: DateTime(2026, 4, 10),
        type: CalendarEventType.evento,
        course: "Engenharia de Software",
        authorId: "1",
        authorName: "Coordenação",
        isPersonal: false,
        createdAt: DateTime(2026, 3, 1),
        updatedAt: DateTime(2026, 3, 1),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed de Eventos"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          return EventCard(event: eventos[index]);
        },
      ),
    );
  }
}