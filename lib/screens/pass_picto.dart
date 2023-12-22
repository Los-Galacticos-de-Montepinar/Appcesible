import 'package:appcesible/models/gallery_model.dart';
import 'package:flutter/material.dart';

import 'package:appcesible/services/user_service.dart';
import 'package:appcesible/services/media_service.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/screens/home_student.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/widget_top_initial.dart';

class PictoPassw extends StatefulWidget {
  const PictoPassw({super.key, required this.user});

  final UserModel user;

  @override
  State<PictoPassw> createState() => _PictoPasswState();
}

class _PictoPasswState extends State<PictoPassw> {
  List<Image> selectedImages = [];
  bool correct = false;
  List<int> download = List.generate(9, (index) => index + 4);
  List<int> codes = [];
  final List<Image> images = [];
  bool initialized = false;
  late final UserModel user;
  List<GalleryModel> galleryList = [];
  List<String> description = [];

  Future getImages() async {
    try {
      if (!initialized) {
        galleryList = await getGallery();

        for (int i = 0; i < download.length; i++) {
          Image img = await downloadImage(download[i]);
          images.add(img);
          description.add(galleryList[i + 3].description);
          codes.add(download[i]);
          print(images.length);
        }
      }

      setState(() {
        initialized = true;
      });
    } catch (error) {
      print("Error downloading image: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: getImages(),
        builder: (context, snapshot) {
          return Scaffold(
              appBar: const TopBarInitial(
                showArrow: true,
              ),
              body: (initialized ||
                      snapshot.connectionState == ConnectionState.done ||
                      images.isNotEmpty)
                  ? Column(
                      children: [
                        Expanded(
                          child: FirstGrid(
                            onImagesSelected: (images, state) {
                              setState(() {
                                selectedImages = images;
                                correct = state;
                              });
                            },
                            images: images,
                            codes: codes,
                            user: widget.user,
                            description: description,
                          ),
                        ),
                        SizedBox(
                          height: 139,
                          child: SecondGrid(
                              selectedImages: selectedImages, correct: correct, description: description,),
                        ),
                      ],
                    )
                  : const LoadingDialog());
        },
      ),
    );
  }
}

class FirstGrid extends StatefulWidget {
  final Function(List<Image>, bool) onImagesSelected;
  final List<Image> images;
  final List<int> codes;
  final UserModel user;
  final List<String> description;

  FirstGrid(
      {required this.onImagesSelected,
      required this.images,
      required this.codes,
      required this.user,
      required this.description});

  @override
  _FirstGridState createState() => _FirstGridState();
}

class _FirstGridState extends State<FirstGrid> {
  bool correct = false;
  int pos = 0;
  int consecutiveCorrect = 0;

  List<int> download = List.generate(9, (index) => index + 4);

  @override
  void initState() {
    super.initState();
  }

  List<bool> selected = List.generate(9, (index) => false);
  List<Image> selectedImages = [];

  Future<void> checkPass(int pos, int code) async {
    correct = await pictoAuthenticateUser0(widget.user, code.toString(), pos);
  }

  String deletePNG(String description) {
    // Encontrar la posición del último punto
    int dot = description.lastIndexOf(".");

    // Verificar si se encontró un punto y si la extensión es ".png"
    if (dot != -1 && description.substring(dot) == ".png") {
      // Obtener una subcadena que excluya la extensión
      return description.substring(0, dot);
    } else {
      // Devolver el nombre de archivo original si no se encuentra ".png"
      return description;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = (screenWidth / 2 - (3 - 1) * 10) / 3;
    double imageHeight = (screenHeight / 3 - (3 - 1) * 10) / 3;

    if (screenHeight < 660) {
      imageWidth = imageWidth.clamp(120.0, 120.0);
    } else if (screenHeight < 800) {
      imageWidth = imageWidth.clamp(150.0, 150.0);
    } else if (screenHeight < 960) {
      imageWidth = imageWidth.clamp(200.0, 200.0);
    } else {
      imageWidth = imageWidth.clamp(250.0, 250.0);
    }

    imageHeight = imageHeight.clamp(250.0, 250.0);

    double crossAxisSpacing = (screenWidth - imageWidth * 3) / (3 - 1);
    crossAxisSpacing = crossAxisSpacing.clamp(0.0, double.infinity);
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: crossAxisSpacing + 5,
      mainAxisSpacing: 20,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      children: List.generate(9, (index) {
        if (widget.images.isNotEmpty) {
          return GestureDetector(
            onTap: () async {
              NavigatorState navigator = Navigator.of(context);

              setState(() {
                selected[index] = !selected[index];
                selectedImages.add(widget.images[index]);
              });

              await checkPass(pos, widget.codes[index]);
              pos++;

              widget.onImagesSelected(selectedImages, correct);

              if (correct) {
                consecutiveCorrect++;
                if (consecutiveCorrect == 3) {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => const HomeStudentInit(),
                    ),
                  );
                  consecutiveCorrect = 0;
                }
              } else {
                consecutiveCorrect = 0;
              }

              if (!correct) {
                selectedImages = [];
                pos = 0;
              }
            },
            child: Center(
              child: Image(
                image: widget.images[index].image,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
                semanticLabel: index < widget.description.length
                    ? deletePNG(widget.description[index])
                    : 'Descripción no disponible',
              ),
            ),
          );
        } else {
          return LoadingDialog();
        }
      }),
    );
  }
}

class SecondGrid extends StatefulWidget {
  final List<Image> selectedImages;
  final bool? correct;
  final List<String> description;

  SecondGrid({required this.selectedImages, required this.correct, required this.description});

  @override
  _SecondGridState createState() => _SecondGridState();
}

class _SecondGridState extends State<SecondGrid> {

  String deletePNG(String description) {
    // Encontrar la posición del último punto
    int dot = description.lastIndexOf(".");

    // Verificar si se encontró un punto y si la extensión es ".png"
    if (dot != -1 && description.substring(dot) == ".png") {
      // Obtener una subcadena que excluya la extensión
      return description.substring(0, dot);
    } else {
      // Devolver el nombre de archivo original si no se encuentra ".png"
      return description;
    }
  }

  @override
  Widget build(BuildContext context) {
    //checkPass();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.grey,
      ),
      child: GridView.count(
        crossAxisCount: 3,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        padding: const EdgeInsets.all(8),
        children: List.generate(widget.selectedImages.length, (index) {
          bool correct = widget.correct ?? false;
          if (correct) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Image(
                    image: widget.selectedImages[index].image,
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
                    semanticLabel: index < widget.description.length
                    ? "Imagen seleccionada" + deletePNG(widget.description[index])
                    : 'Descripción no disponible',
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: Image.asset(
                    'assets/images/wrong.png',
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
                    semanticLabel: "Error",
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}