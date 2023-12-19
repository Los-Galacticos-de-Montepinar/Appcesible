import 'package:appcesible/command/session_command.dart';
import 'package:appcesible/models/gallery_model.dart';
import 'package:appcesible/models/task_model.dart';
import 'package:appcesible/screens/screenutil_init.dart';
import 'package:appcesible/screens/student_diary.dart';
import 'package:flutter/material.dart';
import 'package:pair/pair.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StudentDiaryInit extends StatelessWidget {
  const StudentDiaryInit({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const StudentDiary();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const StudentDiary();
      },
    );
  }
}


// abstract class SelectionState<T extends StatefulWidget> extends State<T> {
//   // List with the task id and the profile picture url
//   int currentIndex = 0;
//   List<TaskModel> taskList = [];
//   // Image defaultImg = Image.file(file)
//   List<Pair<GalleryModel, Image>> images = [];

//   bool initialized = false;

//   bool _imageNeeded(int id) {
//     for (TaskModel task in taskList) {
//       if (task.id == id) {
//         return true;
//       }
//     }

//     return false;
//   }

//   Future initializeTaskList() async {
//     if (!initialized) {
//       await initSession();
      
//       taskList = await getAllUsers();

//       List<GalleryModel> galleryList = await getGallery();
//       for (GalleryModel image in galleryList) {
//         if (_imageNeeded(image.id)) {
//           Image img = await downloadImage(image.id);
//           images.add(Pair(image, img));
//         }
//       }

//       initialized = true;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   void returnPage() {
//     Navigator.pop(context);
//   }

//   void nextUser() {
//     setState(() {
//       currentIndex = (currentIndex + 1) % profileList.length;
//     });
//   }

//   void previousUser() {
//     setState(() {
//       currentIndex = (currentIndex - 1) % profileList.length;
//     });
//   }

//   void selectUser(int index) {
//     UserModel user = profileList[index];
//     user.idProfileImg = images.firstWhere((pair) => (pair.key.id == user.idProfileImg)).key.id;

//     // Maneja la acción al hacer clic en la imagen.
//     print('Usuario clickado, número: ${profileList[index].id}');

//     if (user.userType == 1) {
//       // Falta la condición para modo de visualización
//       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//         return PictoPassw();
//       }));
//     } else {
//       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
//         return Login(user: user);
//       }));
//     }
//   }

//   Widget imageWidget(int id) {
//     return Container(
//       height: 200,
//       width: 200,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           image: DecorationImage(
//             image: images.firstWhere((element) => (element.key.id == profileList[id].idProfileImg)).value.image,
//             fit: BoxFit.cover
//           ),
//         ),
//     );
//   }
// }
