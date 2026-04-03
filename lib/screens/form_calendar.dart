import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_application/models/calendar_event.dart';

class FormCalendar extends StatefulWidget {
const FormCalendar({super.key});

@override
  State<FormCalendar> createState()=> _FormCalendarState();


}

class _FormCalendarState extends State<FormCalendar>{
final TextEditingController _titleController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
DateTime? _selectedDate;
CalendarEventType _eventSelected = CalendarEventType.pessoal;



@override
  void dispose(){
  _titleController.dispose();
  _descriptionController.dispose();
  super.dispose();
}
Future<void> _pickDate() async{
  final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime.now().add(const Duration(days: 365));
   DateTime? picked = await showDatePicker(context: context, firstDate: _firstDate, lastDate: _lastDate);
   if(picked != null) {
 setState(() {
   _selectedDate = picked;
 });
}

}
@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Registre um evento',
          style: TextStyle(
          color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _titleController,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.green.shade400, width: 2.0),
                ),
                hintText: "Informe o titulo",
                prefixIcon: Icon(Icons.title),
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
                  borderSide: BorderSide(color: Colors.green.shade400, width: 2.0),
                ),
                hintText: "Informe a descrição",
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.green.shade400),
                      const SizedBox(width: 12.0),
                      Text(
                        _selectedDate == null ? "Selecione uma data" : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: _selectedDate == null ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
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
              children: CalendarEventType.values.map((type){
                return ChoiceChip(
                  label: Text(type.label),
                  selected: _eventSelected == type,
                  selectedColor: Colors.green.shade400,
                  labelStyle: TextStyle(
                    color: _eventSelected == type ? Colors.white : Colors.black54,
                  ),
                  onSelected: (value) {
                    setState(() => _eventSelected = type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height:24.0),
            ElevatedButton(onPressed: () {
              if (_titleController.text
                  .trim()
                  .isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Informe um titulo')),
                );
                return;
              }
              if (_selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Informe uma data')),
                );
                return;
              }
              final now = DateTime.now();
              final newEvent = CalendarEvent(
                id: now.millisecondsSinceEpoch.toString(),
                title: _titleController.text.trim(),
                description: _descriptionController.text
                    .trim()
                    .isEmpty ? null : _descriptionController.text.trim(),
                date: _selectedDate!,
                type: _eventSelected,
                authorId: 'local_user',
                authorName: 'Você',
                isPersonal: true,
                createdAt: now,
                updatedAt: now,
              );
              Navigator.pop(context, newEvent);
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              child: Text('Salvar Evento', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        )
      ),
    );
}
}
