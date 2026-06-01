import 'package:sqflite/sqflite.dart';
import '../database/conexao.dart';
import '../models/aluno.dart';
import '../models/atendimento.dart';

class AtendimentoDao {
  final Database db;
  AtendimentoDao(this.db);

  // * deixando as operações básicas em uma linha só
  // CORREÇÃO 1: a.nomeAluno.id em vez de a.id
  Future<int> inserir(Atendimento a) async => await db.insert('atendimento', {
    'data_hora': a.data_hora,
    'assunto': a.assunto,
    'aluno_id': a.aluno.id,
  });

  // CORREÇÃO 2: a.nomeAluno.id em vez de a.id
  Future<int> atualizar(Atendimento a) async => await db.update(
    'atendimento',
    {'data_hora': a.data_hora, 'assunto': a.assunto, 'aluno_id': a.aluno.id},
    where: 'id = ?',
    whereArgs: [a.id],
  );

  Future<int> excluir(int id) async =>
      await db.delete('atendimento', where: 'id = ?', whereArgs: [id]);

  // CORREÇÃO 3 e 4: alu.id AS alu_id  |  ON a.aluno_id = alu.id
  static const _sql = '''
    SELECT a.id AS a_id, a.data_hora, a.assunto, alu.id AS alu_id, alu.nome, alu.ra
    FROM atendimento a INNER JOIN aluno alu ON a.aluno_id = alu.id
  ''';

  // reaproveitando _sql
  Future<List<Atendimento>> buscarTodos() async {
    final res = await db.rawQuery(_sql);
    return res.map(_mapear).toList();
  }

  Future<Atendimento?> buscarPorId(int id) async {
    final res = await db.rawQuery('$_sql WHERE a.id = ?', [id]);
    return res.isEmpty ? null : _mapear(res.first); // Operador ternário
  }

  // 4. Tradutor manual super compacto
  Atendimento _mapear(Map<String, dynamic> m) => Atendimento(
    id: m['a_id'],
    data_hora: m['data_hora'],
    assunto: m['assunto'],
    aluno: Aluno(
      id: m['alu_id'],
      nome: m['nome'],
      ra: m['ra'],
    ), // Cria o aluno direto na chamada
  );
}
