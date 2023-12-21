import 'package:flutter/material.dart';

class TopScreenConfirmations extends StatelessWidget
    implements PreferredSizeWidget {
  final String texto;
  final String image;

  const TopScreenConfirmations({
    super.key,
    required this.texto,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 10,
      toolbarHeight: 150,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 80, // Duplica la altura (40 * 2)
            width: 80, // Duplica el ancho (40 * 2)
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[400],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(150); // Proporciona una implementación adecuada
}
