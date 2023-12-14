import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: const Color(0xFFFFDC83).withOpacity(0.2),
          color: const Color(0xFFFFDC83).withOpacity(0.7),
          strokeWidth: 5.0,
        ),
      ),
    );
  }
}