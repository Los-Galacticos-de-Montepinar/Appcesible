import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class SelectUserWeb extends StatelessWidget {
  const SelectUserWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: _imageWidget(image: 'assets/images/alonso.png')),
                const SizedBox(width: 40),
                Expanded(
                    child: _imageWidget(image: 'assets/images/ronaldo.png')),
                const SizedBox(width: 40),
                Expanded(
                    child: _imageWidget(image: 'assets/images/ronaldo.png')),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                    child: _imageWidget(image: 'assets/images/alonso.png')),
                const SizedBox(width: 40),
                Expanded(
                    child: _imageWidget(image: 'assets/images/ronaldo.png')),
                const SizedBox(width: 40),
                Expanded(
                    child: _imageWidget(image: 'assets/images/ronaldo.png')),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                    child: _imageWidget(image: 'assets/images/alonso.png')),
                const SizedBox(width: 40),
                Expanded(
                    child: _imageWidget(image: 'assets/images/ronaldo.png')),
                const SizedBox(width: 40),
                Expanded(
                    child: _imageWidget(image: 'assets/images/ronaldo.png')),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget({required String image}) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
