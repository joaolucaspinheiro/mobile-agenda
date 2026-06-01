import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_application/screens/event_detail.dart';

import '../data/calendar_event_dao.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';
import './form_calendar.dart';
import './form_edit_calendar.dart';
import 'event_list.dart';
import 'teacher_home.dart';

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
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await CalendarEventDao.instance.findPersonal();
    if (!mounted) return;
    setState(() {
      _events
        ..clear()
        ..addAll(events);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _selectedDay == null
        ? <CalendarEvent>[]
        : _events.where((event) => isSameDay(event.date, _selectedDay)).toList();

    return AppScaffold(
      title: 'Calendario',
      actions: [
        IconButton(
          icon: const Icon(Icons.school),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TeacherHome()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.event_note),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventList(events: _events)),
            );
          },
        ),
      ],
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(10.0),
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
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedDay = selectedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: selectedEvents.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum evento neste dia.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedEvents[index];
                      return ListTile(
                        title: Text(event.title),
                        subtitle: Text(event.type.label),
                        leading: Icon(Icons.event, color: Colors.green.shade400),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetail(event: event),
                            ),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.green),
                              onPressed: () async {
                                final updatedEvent = await Navigator.push<CalendarEvent>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormEditCalendar(event: event),
                                  ),
                                );
                                if (updatedEvent != null) {
                                  await CalendarEventDao.instance.save(updatedEvent);
                                  setState(() {
                                    _selectedDay = updatedEvent.date;
                                    _focusedDay = updatedEvent.date;
                                  });
                                  await _loadEvents();
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await CalendarEventDao.instance.delete(event.id);
                                await _loadEvents();
                              },
                            ),
                          ],
                        ),
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
            await CalendarEventDao.instance.save(newEvent);
            setState(() {
              _selectedDay = newEvent.date;
              _focusedDay = newEvent.date;
            });
            await _loadEvents();
          }
        },
        backgroundColor: Colors.green.shade400,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
