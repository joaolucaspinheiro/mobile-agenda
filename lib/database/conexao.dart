import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Conexao {
  //* Parte da lógica e conexão com o banco

  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;

    final caminho = join(
      await getDatabasesPath(),
      'banco.db',
    ); //*Busca a pasta nativa para salvar os dados

    _db = await openDatabase(
      caminho,
      version: 1,
      onConfigure: (db) async {
        //* ativando as chaves estrangeiras
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        //* aqui é onde cria a tabela pai antes da tabela filha
        await db.execute('''
          CREATE TABLE IF NOT EXISTS aluno (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            ra TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS atendimento (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data_hora TEXT,
            aluno_id INTEGER,
            assunto TEXT,
            FOREIGN KEY (aluno_id) REFERENCES aluno(id) ON DELETE CASCADE
          )
        ''');
      },
    );
    return _db!;
  }
}
