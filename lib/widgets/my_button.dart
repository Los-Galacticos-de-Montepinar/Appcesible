import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  final void Function()? onPressed; // Hacer la función opcional

  const MyButton({super.key, required this.buttonText, this.onPressed});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 500), // Ajusta la duración a 500 milisegundos
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves
            .easeOutBack, // Cambia la curva para hacer la animación más notoria
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _animationController.forward(from: 0.0);
        // Verifica si la función onPressed no es nula antes de llamarla
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFBF1717), // Color del texto blanco
      ),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Aumenta el espaciado para hacer la animación más notoria
          child: Text(widget.buttonText),
        ),
      ),
    );
  }
}