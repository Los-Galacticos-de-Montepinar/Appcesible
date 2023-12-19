import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/services/user_service.dart';

class PictoPassw extends StatefulWidget {
  PictoPassw({Key? key}) : super(key: key);

  @override
  _PictoPasswState createState() => _PictoPasswState();
}

class _PictoPasswState extends State<PictoPassw> {
  List<String> selectedImages = [];
  bool correct = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: TopMenu(
          onHomeTap: () {},
        ),
        body: Column(
          children: [
            Expanded(
              child: FirstGrid(
                onImagesSelected: (images, state) {
                  setState(() {
                    selectedImages = images;
                    correct = state;
                  });
                },
              ),
            ),
            SizedBox(
              height: 139,
              child:
                  SecondGrid(selectedImages: selectedImages, correct: correct),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstGrid extends StatefulWidget {
  final Function(List<String>, bool) onImagesSelected;

  FirstGrid({required this.onImagesSelected});

  @override
  _FirstGridState createState() => _FirstGridState();
}

class _FirstGridState extends State<FirstGrid> {
  bool correct = false;
  int pos = 0;

  final List<String> images = [
    'https://api.arasaac.org/v1/pictograms/2462?download=false',
    'https://api.arasaac.org/v1/pictograms/25187?download=false',
    'https://api.arasaac.org/v1/pictograms/28577?download=false',
    'https://api.arasaac.org/v1/pictograms/2475?download=false',
    'https://api.arasaac.org/v1/pictograms/7166?download=false',
    'https://api.arasaac.org/v1/pictograms/3102?download=false',
    'https://api.arasaac.org/v1/pictograms/6981?download=false',
    'https://api.arasaac.org/v1/pictograms/38968?download=false',
    'https://api.arasaac.org/v1/pictograms/4918?download=false',
  ];


  List<bool> selected = List.generate(9, (index) => false);
  List<String> selectedImages = [];

  UserModel user = UserModel(
    id: 3,
    userName: 'Lucy Steel',
    idProfileImg: 5,
    userType: 5,
    idClass: 1,
    loginType: 0
  );

  Future<void> checkPass(int pos) async {
    correct = await pictoAuthenticateUser0(user, "2", pos);
  }    

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageWidth = (screenWidth / 2 - (3 - 1) * 10) / 3;
    double imageHeight = (screenHeight / 3 - (3 - 1) * 10) / 3;

    // print(screenHeight);
    // print(screenWidth);

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

    //double gridViewHeight = imageWidth * 3 + 20;
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
          onTap: () async {
            setState(() {
              selected[index] = !selected[index];
              selectedImages.add(images[index]);
            });

            await checkPass(pos);
            pos++;
            // Llama a la función de devolución de llamada
            widget.onImagesSelected(selectedImages, correct);
            if (!correct) {
                selectedImages = [];
                pos=0;
              }
          },
          child: Center(
            child: Image.network(
              images[index],
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}

class SecondGrid extends StatefulWidget {
  final List<String> selectedImages;
  final bool? correct;

  SecondGrid({required this.selectedImages, required this.correct});

  @override
  _SecondGridState createState() => _SecondGridState();
}

class _SecondGridState extends State<SecondGrid> {
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
                  child: Image.network(
                    widget.selectedImages[index],
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
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

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PictoPassw(),
    );
  }
}
