import 'package:flutter/material.dart';
import '../models/calendar_event.dart';

class EventCard extends StatelessWidget {
  final CalendarEvent event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "${event.date.day}/${event.date.month}/${event.date.year}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 6),

            Text(event.type.label),

            if (event.description != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(event.description!),
              ),
          ],
        ),
      ),
    );
  }
}