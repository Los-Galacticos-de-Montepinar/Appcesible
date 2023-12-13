import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? colorText;
  final Color? colorBackground;

  const MyButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    this.colorText,
    this.colorBackground,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
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
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: widget.colorText ?? Colors.white,
        backgroundColor: widget.colorBackground ?? const Color(0xFFBF1717),
      ),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(widget.buttonText),
        ),
      ),
    );
  }
}
