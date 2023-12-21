import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Image image;

  const ImageWidget({super.key, required this.image});

  Widget _imageWidget() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: image.image,
          fit: BoxFit.cover
        )
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 4.0,
        ),
      ),
      child: ClipOval(
        child: _imageWidget(),
      ),
    );
  }
}
