import 'package:flutter/material.dart';
import 'package:test_application/widgets/academus_app_bar.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const AppScaffold({super.key, required this.title, required this.body, this.floatingActionButton, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AcademusAppBar(title: title, actions: actions),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}