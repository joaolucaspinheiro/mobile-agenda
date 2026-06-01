import 'package:test_application/models/aluno.dart';

class Atendimento {
  final int? id;
  final Aluno aluno;
  final String assunto;
  final String data_hora;

  Atendimento({
    this.id,
    required this.aluno,
    required this.assunto,
    required this.data_hora,
  });
}
