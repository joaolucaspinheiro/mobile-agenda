import 'package:sqflite/sqflite.dart';
import '../database/conexao.dart';
import '../models/aluno.dart';

class AlunoDao {
  final Database db;
  AlunoDao(this.db);

  Future<int> inserir(Aluno a) async {
    return await db.insert('aluno', {'nome': a.nome, 'ra': a.ra});
  }

  Future<int> atualizar(Aluno a) async {
    return await db.update(
      'aluno',
      {'nome': a.nome, 'ra': a.ra},
      where: 'id = ?',
      whereArgs: [a.id],
    );
  }

  Future<int> excluir(int id) async {
    return await db.delete('aluno', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Aluno>> buscarTodos() async {
    final resultado = await db.query('aluno');
    return resultado.map(_mapear).toList(); // Usa a função enxuta lá de baixo
  }

  Future<Aluno?> buscarPorId(int id) async {
    final resultado = await db.query('aluno', where: 'id = ?', whereArgs: [id]);
    if (resultado.isEmpty) return null;
    return _mapear(resultado.first);
  }

  // mapeamento básico, só para evitar repetição de código
  Aluno _mapear(Map<String, dynamic> map) {
    return Aluno(id: map['id'], nome: map['nome'], ra: map['ra']);
  }
}
