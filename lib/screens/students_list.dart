import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopMenu(),
    );
  }
}
