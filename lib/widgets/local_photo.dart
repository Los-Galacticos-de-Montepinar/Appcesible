import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class UploadPicture extends StatefulWidget{
  const UploadPicture({super.key});

  @override
  UploadPictureState createState() => UploadPictureState();

  static UploadPictureState? of(BuildContext context) {
    return context.findAncestorStateOfType<UploadPictureState>();
  }
}

class UploadPictureState extends State<UploadPicture>{

  late XFile? imageFile;
  Image photo=Image.asset("assets/images/bellingol.jpg", fit: BoxFit.fill);

Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = image;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context){
    return IconButton(
      iconSize: 20,
      icon: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: photo.image, fit: BoxFit.fill)
          ),
          height: 192,
          width: 192,
          child: const ClipOval(),
      ),
      onPressed: ()=>{
        pickImage().then((value) => {
          imageFile == null
                ? {}
                : {
                  photo=Image.file(File(imageFile!.path)),
                    setState(()=>{})
                  }
        }),
        print(photo)
        },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
      ),
    );
  }

}