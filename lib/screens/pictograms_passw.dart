import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class PictoPassw extends StatefulWidget {
  PictoPassw({Key? key}) : super(key: key);

  @override
  _PictoPasswState createState() => _PictoPasswState();
}

class _PictoPasswState extends State<PictoPassw> {
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: TopMenu(),
        body: Column(
          children: [
            SizedBox(
              height: 450,
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

  FirstGrid({required this.onImagesSelected});

  @override
  _FirstGridState createState() => _FirstGridState();
}

class _FirstGridState extends State<FirstGrid> {
  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    // ... Agrega más URL de imágenes según sea necesario
  ];

  List<bool> selected = List.generate(9, (index) => false);
  List<String> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      physics: NeverScrollableScrollPhysics(),
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
              border: selected[index] ? Border.all(color: Colors.blue, width: 2) : null,
            ),
            child: Center(
              child: Image.network(
                images[index],
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

  SecondGrid({required this.selectedImages});

  @override
  _SecondGridState createState() => _SecondGridState();
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
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(8),
        children: List.generate(widget.selectedImages.length, (index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Center(
              child: Image.network(
                widget.selectedImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }
}

/*import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

import 'students_list.dart';

class PictoPassw extends StatefulWidget {
  PictoPassw({Key? key}) : super(key: key);

  @override
  _PictoPasswState createState() => _PictoPasswState();

}

class _PictoPasswState extends State<PictoPassw> {

  List<String> selectedImages = [];

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: TopMenu(),
          body: Column(
            children: [
              SizedBox(
                height: 450,
                child: FirstGrid(
                  onImagesSelected: (images){
                    setState(() {
                      selectedImages = images;  
                    });
                  }
                ),
              ),
              SizedBox(
                height: 139,
                child: SecondGrid(selectedImages: selectedImages),
              )
            ],
          )),
    );
  }

}

class FirstGrid extends StatefulWidget {

  final Function(List<String>) onImagesSelected;

  FirstGrid({required this.onImagesSelected});

  @override
  _PictoPasswState createState() => _PictoPasswState();
}

class SecondGrid extends StatefulWidget {
  final List<String> selectedImages;
  SecondGrid({required this.selectedImages});

  @override
  _SelectedPicto createState() => _SelectedPicto();
}

class _FirstGridState extends State<FirstGrid> {
  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy7at8Nr1dw1OR7MYlsJN44wQAOlJrUIW8dGRdy0D4&s',
    // ... Agrega más URL de imágenes según sea necesario
  ];

  List<bool> selected = List.generate(9, (index) => false);
  List<String> selectedImages = [];
  int pointer = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(8),
      children: List.generate(9, (index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                selected[index] = !selected[index];
                selectedImages.add(images[index]);
                //SecondGrid();
              });

              widget.onImagesSelected(selectedImages);

              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SecondGrid(selectedImages: selectedImages),
                ),
              );*/
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
                  fit: BoxFit.cover,
                ),
              ),
            ));
      }),
    );
  }
}

class _SelectedPicto extends State<SecondGrid> {
  late final List<String> selectedImages;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      padding: const EdgeInsets.all(8),
      children: [
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        )
      ],
    );
  }
}*/