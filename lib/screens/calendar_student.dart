import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:test_application/screens/event_detail.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';
import './form_calendar.dart';
import './form_edit_calendar.dart';
import 'event_list.dart';

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
    final now = DateTime.now();
    _events.addAll([
      CalendarEvent(
        id: '1',
        title: 'Prova de Cálculo',
        description: 'Capítulos 1 ao 5',
        date: now,
        type: CalendarEventType.prova,
        authorId: 'local_user',
        authorName: 'Você',
        isPersonal: true,
        createdAt: now,
        updatedAt: now,
      ),
      CalendarEvent(
        id: '2',
        title: 'Trabalho de POO',
        description: 'Entregar no AVA',
        date: now.add(Duration(days: 3)),
        type: CalendarEventType.trabalho,
        authorId: 'local_user',
        authorName: 'Você',
        isPersonal: true,
        createdAt: now,
        updatedAt: now,
      ),
      CalendarEvent(
        id: '3',
        title: 'Seminário de TCC',
        description: null,
        date: now.add(Duration(days: 7)),
        type: CalendarEventType.seminario,
        authorId: 'local_user',
        authorName: 'Você',
        isPersonal: true,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
  }
  @override
  Widget build(BuildContext context) {
    final selectedEvents = _selectedDay == null
        ? []
        : _events.where((event) => isSameDay(event.date, _selectedDay)).toList();
    return AppScaffold(
      title: 'Calendário',
      actions: [
        IconButton(
          icon: Icon(Icons.event_note),
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
                Navigator.push<CalendarEvent>(
                  context,
                  MaterialPageRoute(builder: (context) => EventDetail(event: event)),
                );
              },
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
              IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () async {
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
            ),
            IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Excluir evento'),
                      content: Text('Tem certeza que deseja excluir "${event.title}"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() => _events.removeWhere((e) => e.id == event.id));
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(foregroundColor: Colors.red),
                          child: Text('Excluir'),
                        ),
                      ],
                    ),
                  );
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
