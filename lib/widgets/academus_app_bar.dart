import 'package:flutter/material.dart';

class AcademusAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AcademusAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
  return AppBar(
    title: Text('ACADEMUS - $title',
      style: TextStyle(color: Colors.black,
          fontSize: 24.0,
          fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    backgroundColor: Colors.green.shade400,
    actions: actions,
  );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
