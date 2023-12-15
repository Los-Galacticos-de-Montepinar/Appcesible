import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPicture {
  static Future<File> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return File(image!.path);
    } catch (e) {
      throw Exception(e);
    }
  }
}

// class UploadPicture extends StatefulWidget{
//   const UploadPicture({super.key});

//   @override
//   UploadPictureState createState() => UploadPictureState();

//   static UploadPictureState? of(BuildContext context) {
//     return context.findAncestorStateOfType<UploadPictureState>();
//   }
// }

// class UploadPictureState extends State<UploadPicture> {
//   Image photo = Image.asset("assets/images/addPicture.png", fit: BoxFit.fill);
//   File? file;

//   Future pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       XFile? image = await picker.pickImage(source: ImageSource.gallery);
      
//       setState(() {
//         file = File(image!.path);
//       });

//       print('file - $file');
//     } catch (e) {
//       throw Exception(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context){
//     return IconButton(
//       iconSize: 20,
//       icon: Container(
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(image: photo.image, fit: BoxFit.fill)
//           ),
//           height: 192,
//           width: 192,
//           child: const ClipOval(),
//       ),
//       onPressed: () {
//         pickImage().then((value) {
//           setState(() {
//             photo = Image.file(file!);
//             print('photo - $photo');
//           });
//         });
//       },
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
//       ),
//     );
//   }
// }