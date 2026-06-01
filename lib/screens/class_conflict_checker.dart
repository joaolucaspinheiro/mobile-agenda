import 'package:flutter/material.dart';

import '../data/calendar_event_dao.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';

class ClassConflictChecker extends StatefulWidget {
  const ClassConflictChecker({super.key});

  @override
  State<ClassConflictChecker> createState() => _ClassConflictCheckerState();
}

class _ClassConflictCheckerState extends State<ClassConflictChecker> {
  TurmaEnum? _selectedTurma;
  final List<CalendarEvent> _allEvents = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await CalendarEventDao.instance.findTeacherEvents();
    if (!mounted) return;
    setState(() {
      _allEvents
        ..clear()
        ..addAll(events);
    });
  }

  List<CalendarEvent> get _filteredEvents {
    if (_selectedTurma == null) return [];
    final filtered = _allEvents
        .where((event) => event.course == _selectedTurma)
        .toList();
    filtered.sort((a, b) => a.date.compareTo(b.date));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredEvents;

    return AppScaffold(
      title: 'Consultar Conflitos',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<TurmaEnum>(
              initialValue: _selectedTurma,
              decoration: InputDecoration(
                labelText: 'Selecione a Turma para analisar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Colors.green.shade400,
                    width: 2.0,
                  ),
                ),
                prefixIcon: const Icon(Icons.group),
              ),
              items: TurmaEnum.values.map((turma) {
                return DropdownMenuItem(
                  value: turma,
                  child: Text(turma.label),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedTurma = value),
            ),
            const SizedBox(height: 24.0),
            if (_selectedTurma != null) ...[
              Text(
                'Agenda da Turma: ${_selectedTurma!.label}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12.0),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum evento marcado para esta turma.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12.0),
                        itemBuilder: (context, index) {
                          final event = filtered[index];
                          final isCritical =
                              event.type == CalendarEventType.prova;

                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isCritical
                                    ? Colors.red.shade100
                                    : Colors.blue.shade100,
                                child: Icon(
                                  isCritical
                                      ? Icons.warning_amber_rounded
                                      : Icons.info_outline,
                                  color: isCritical
                                      ? Colors.red.shade700
                                      : Colors.blue.shade700,
                                ),
                              ),
                              title: Text(event.title),
                              subtitle: Text(
                                'Docente: ${event.authorName}\nTipo: ${event.type.label}',
                              ),
                              isThreeLine: true,
                              trailing: Text(
                                '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ] else
              const Expanded(
                child: Center(
                  child: Text(
                    'Escolha uma turma para verificar se ja existem provas ou trabalhos marcados por professores.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
