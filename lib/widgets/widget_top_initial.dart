import 'package:flutter/material.dart';

class TopBarInitial extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool showArrow; // Nuevo atributo de texto

  const TopBarInitial({
    super.key,
    required this.showArrow
    }) : preferredSize = const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      toolbarHeight: 120,
      automaticallyImplyLeading: false,
      title: (showArrow)
        ? GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset(
            'assets/images/back_arrow.png',
            width: 300,
            height: 300,
          ),
        )
        : const Text(
          'AppCesible',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      centerTitle: true,
      backgroundColor: const Color(0xFF9E9E9E),
    );
  }
}
