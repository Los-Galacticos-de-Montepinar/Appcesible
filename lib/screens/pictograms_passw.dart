import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class PictoPassw extends StatefulWidget {
  const PictoPassw({super.key});

  @override
  State<PictoPassw> createState() => _PictoPasswState();
}

class _PictoPasswState extends State<PictoPassw> {
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const TopMenu(),
        body: Column(
          children: [
            Expanded(
              child: FirstGrid(
                onImagesSelected: (images) {
                  setState(() {
                    selectedImages = images;
                  });
                },
              ),
            ),
            SizedBox(
              height: 139,
              child: SecondGrid(selectedImages: selectedImages),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstGrid extends StatefulWidget {
  final Function(List<String>) onImagesSelected;

  const FirstGrid({super.key, required this.onImagesSelected});

  @override
  State<FirstGrid> createState() => _FirstGridState();
}

class _FirstGridState extends State<FirstGrid> {
  final List<String> images = [
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/25187?download=false',
    'https://api.arasaac.org/v1/pictograms/28577?download=false',
    'https://api.arasaac.org/v1/pictograms/2475?download=false',
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/2462?download=false',

  ];

  List<bool> selected = List.generate(9, (index) => false);
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = (screenWidth / 2 - (3 - 1) * 10) / 3;

    imageWidth = imageWidth.clamp(250.0, 250.0);
    double gridViewHeight = imageWidth * 3 + 20;
    double crossAxisSpacing = (screenWidth - imageWidth * 3) / (3 - 1);
    crossAxisSpacing = crossAxisSpacing.clamp(0.0, double.infinity);

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: crossAxisSpacing + 5,
      mainAxisSpacing: 20,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      children: List.generate(9, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selected[index] = !selected[index];
              selectedImages.add(images[index]);
            });

            // Llama a la función de devolución de llamada
            widget.onImagesSelected(selectedImages);
          },
          child: Container(
            decoration: BoxDecoration(
              border: selected[index]
                  ? Border.all(color: Colors.blue, width: 2)
                  : null,
            ),
            child: Center(
              child: Image.network(
                images[index],
                width: imageWidth,
                height: imageWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class SecondGrid extends StatefulWidget {
  final List<String> selectedImages;

  const SecondGrid({super.key, required this.selectedImages});

  @override
  State<SecondGrid> createState() => _SecondGridState();
}

class _SecondGridState extends State<SecondGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.grey,
      ),
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(8),
        children: List.generate(widget.selectedImages.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.topCenter,
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Image.network(
                widget.selectedImages[index],
                width: 125,
                height: 125,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }
}
