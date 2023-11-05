import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class SelectUserApp extends StatelessWidget {
  const SelectUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.teal,
        title: const Text(
          'App View',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            _imageWidget(image: 'assets/images/alonso.png'),
            const SizedBox(height: 40),
            _imageWidget(image: 'assets/images/messi.png'),
            const SizedBox(height: 40),
            _imageWidget(image: 'assets/images/gato.png'),
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
