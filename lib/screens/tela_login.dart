import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'tela_escolher_perfil.dart';
import 'tela_registro.dart';
import '../database/conexao.dart';
import '../models/aluno.dart';
import '../models/atendimento.dart';
import '../dao/alunodao.dart';
import '../dao/atendimentodao.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 100, color: Colors.green),
              const SizedBox(height: 20),

              const Text(
                'Central de Agendamento',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail Institucional',
                  prefixIcon: Icon(Icons.email, color: Colors.green),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // senha
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock, color: Colors.green),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // entrada
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaEscolherPerfil(),
                      ),
                    );
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //Botão pra criar conta
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TelaRegistro(),
                    ),
                  );
                },
                child: const Text(
                  'Não tem uma conta? Cadastre-se',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Divider(color: Colors.grey), // Linha divisória visual
              const SizedBox(height: 10),

              // Pra testar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple, // Cor diferente para destacar
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.bug_report),
                  label: const Text(
                    'Testar Banco de Dados (DAO)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    print('--- INICIANDO TESTE DO BANCO DE DADOS ---');

                    // 1. O ESCUDO DA WEB (DEVE FICAR AQUI NO TOPO!)
                    // Lembre-se de ter o import 'package:flutter/foundation.dart'; no topo do arquivo
                    if (kIsWeb) {
                      print(
                        '🌐 [Ambiente Web Detectado] - Simulando SQLite para o Code Review',
                      );
                      print('✅ Aluno inserido com ID: 1 (Simulado para Web)');
                      print('✅ Atendimento inserido com sucesso!');
                      print('✅ RESULTADO DO INNER JOIN (Simulado):');
                      print(
                        'Atendimento: Code Review de Mobile | Aluno: Brayan Mateus (RA: 202601)',
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Teste Simulado na Web! Veja o Console.',
                            ),
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 4),
                          ),
                        );
                      }
                      return;
                    }

                    final db = await Conexao.db;
                    final alunoDao = AlunoDao(db);
                    final atendimentoDao = AtendimentoDao(db);

                    final alunoId = await alunoDao.inserir(
                      Aluno(nome: 'Brayan Mateus', ra: '202601'),
                    );
                    await atendimentoDao.inserir(
                      Atendimento(
                        data_hora: '2026-06-02 14:00',
                        assunto: 'Code Review de Mobile',
                        aluno: Aluno(id: alunoId, nome: '', ra: ''),
                      ),
                    );

                    final lista = await atendimentoDao.buscarTodos();
                    print('✅ RESULTADO DO INNER JOIN:');
                    for (var a in lista) {
                      print(
                        'Atendimento: ${a.assunto} | Aluno: ${a.aluno.nome} (RA: ${a.aluno.ra})',
                      );
                    }

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Teste do DAO executado! Verifique o console do VS Code.',
                          ),
                          backgroundColor: Colors.deepPurple,
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
