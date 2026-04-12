import 'package:flutter/material.dart';
import '../models/calendar_event.dart';
import '../widgets/app_scaffold.dart';

class FormEditEventTeacher extends StatefulWidget {
  final CalendarEvent event;
  const FormEditEventTeacher({super.key, required this.event});

  @override
  State<FormEditEventTeacher> createState() => _FormEditEventTeacherState();
}

class _FormEditEventTeacherState extends State<FormEditEventTeacher> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;
  TurmaEnum? _selectedCourse;
  late CalendarEventType _eventSelected;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController = TextEditingController(
      text: widget.event.description,
    );
    _selectedDate = widget.event.date;
    _selectedCourse = widget.event.course;
    _eventSelected = widget.event.type;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Editar Evento',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
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
                hintText: 'Informe o título',
                prefixIcon: const Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
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
                hintText: 'Informe a descrição',
                prefixIcon: const Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<TurmaEnum>(
              initialValue: _selectedCourse,
              decoration: InputDecoration(
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
                hintText: 'Selecione a Turma',
                prefixIcon: const Icon(Icons.group),
              ),
              items: TurmaEnum.values.map((turma) {
                return DropdownMenuItem(value: turma, child: Text(turma.label));
              }).toList(),
              onChanged: (value) => setState(() => _selectedCourse = value),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.green.shade400),
                    const SizedBox(width: 12.0),
                    Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Tipo do Evento',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: CalendarEventType.values
                  .where((e) => e != CalendarEventType.pessoal)
                  .map((type) {
                    return ChoiceChip(
                      label: Text(type.label),
                      selected: _eventSelected == type,
                      selectedColor: Colors.green.shade400,
                      labelStyle: TextStyle(
                        color: _eventSelected == type
                            ? Colors.white
                            : Colors.black54,
                      ),
                      onSelected: (_) => setState(() => _eventSelected = type),
                    );
                  })
                  .toList(),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Informe um título')),
                  );
                  return;
                }
                final updated = widget.event.copyWith(
                  title: _titleController.text.trim(),
                  description: _descriptionController.text.trim().isEmpty
                      ? null
                      : _descriptionController.text.trim(),
                  course: _selectedCourse,
                  date: _selectedDate,
                  type: _eventSelected,
                  updatedAt: DateTime.now(),
                );
                Navigator.pop(context, updated);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Salvar Alterações',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
