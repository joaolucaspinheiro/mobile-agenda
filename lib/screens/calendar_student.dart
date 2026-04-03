import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/calendar_event.dart';
import './form_calendar.dart';
import './form_edit_calendar.dart';

class CalendarStudent extends StatefulWidget {
  const CalendarStudent({super.key});
  @override
  State<CalendarStudent> createState() => _CalendarStudentState();
}

class _CalendarStudentState extends State<CalendarStudent> {
  final List<CalendarEvent> _events = [];
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final DateTime _firstDay = DateTime.now().subtract(const Duration(days: 365));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 365));

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _selectedDay == null
        ? []
        : _events.where((event) => isSameDay(event.date, _selectedDay)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ACADEMUS",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TableCalendar(
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.green.shade400,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.green.shade200,
                  shape: BoxShape.circle,
                ),
              ),
              locale: 'pt_BR',
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              calendarFormat: _calendarFormat,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, focusedDay)) {
                  setState(() {
                    _focusedDay = focusedDay;
                    _selectedDay = selectedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
    ),
    const SizedBox(height: 8.0),
      Expanded(
        child: selectedEvents.isEmpty
            ? Center(child: Text('Nenhum evento neste dia.', style: TextStyle(color: Colors.grey)))
            : ListView.builder(
          itemCount: selectedEvents.length,
          itemBuilder: (context, index) {
            final event = selectedEvents[index];
            return ListTile(
              title: Text(event.title),
              subtitle: Text(event.type.label),
              leading: Icon(Icons.event, color: Colors.green.shade400),
              onTap: () async {
                final updatedEvent = await Navigator.push<CalendarEvent>(
                  context,
                  MaterialPageRoute(builder: (context) => FormEditCalendar(event: event)),
                );
                if (updatedEvent != null) {
                  setState(() {
                    final index = _events.indexWhere((e) => e.id == updatedEvent.id);
                    if (index != -1) _events[index] = updatedEvent;
                  });
                }
              },
            );
          },
    ),
    ),
    ],
    ),
    floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newEvent = await Navigator.push<CalendarEvent>(
            context,
            MaterialPageRoute(builder: (context) => const FormCalendar()),
          );
          if (newEvent != null) {
            setState(() => _events.add(newEvent));
          }
        },
      backgroundColor: Colors.green.shade400,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),
      ),
    );
  }
}
