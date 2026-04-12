import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';

class ClassConflictChecker extends StatefulWidget {
  const ClassConflictChecker({super.key});

  @override
  State<ClassConflictChecker> createState() => _ClassConflictCheckerState();
}

class _ClassConflictCheckerState extends State<ClassConflictChecker> {
  TurmaEnum? _selectedTurma;

  // Simulando eventos de vários professores para a mesma turma (dados globais)
  final List<CalendarEvent> _allEvents = [
    CalendarEvent(
      id: 'c1',
      title: 'Prova de Cálculo I',
      description: 'Derivadas e Integrais',
      date: DateTime.now().add(const Duration(days: 3)),
      type: CalendarEventType.prova,
      course: TurmaEnum.ads1,
      authorId: 'other_prof',
      authorName: 'Prof. Marcos',
      isPersonal: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CalendarEvent(
      id: 'c2',
      title: 'Entrega de Banco de Dados',
      description: 'Modelo Lógico',
      date: DateTime.now().add(const Duration(days: 3)),
      type: CalendarEventType.trabalho,
      course: TurmaEnum.ads1,
      authorId: 'other_prof2',
      authorName: 'Profª. Ana',
      isPersonal: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    CalendarEvent(
      id: 'c3',
      title: 'Seminário de Redes',
      description: 'Protocolos TCP/IP',
      date: DateTime.now().add(const Duration(days: 7)),
      type: CalendarEventType.seminario,
      course: TurmaEnum.ads3,
      authorId: 'other_prof',
      authorName: 'Prof. Marcos',
      isPersonal: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<CalendarEvent> get _filteredEvents {
    if (_selectedTurma == null) return [];
    final filtered = _allEvents
        .where((e) => e.course == _selectedTurma)
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
              items: TurmaEnum.values.map((t) {
                return DropdownMenuItem(value: t, child: Text(t.label));
              }).toList(),
              onChanged: (val) => setState(() => _selectedTurma = val),
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

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: isCritical
                                    ? Colors.red.shade200
                                    : Colors.grey.shade200,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
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
                              title: Text(
                                event.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                    'Escolha uma turma para verificar se já existem provas ou trabalhos marcados por outros professores.',
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
