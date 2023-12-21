import 'package:appcesible/screens/task_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:appcesible/models/user_model.dart';
import 'package:appcesible/models/task_model.dart';
import 'package:appcesible/models/assign_model.dart';
import 'package:appcesible/models/class_model.dart';

import 'package:appcesible/services/task_service.dart';
import 'package:appcesible/services/user_service.dart';

import 'package:appcesible/screens/create_material_task_app.dart';
import 'package:appcesible/screens/create_material_task_tab.dart';
import 'package:appcesible/screens/screenutil_init.dart';

import 'package:appcesible/widgets/dialog_list_search.dart';
import 'package:appcesible/widgets/dialog_quantity.dart';
import 'package:appcesible/widgets/dialog_error.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:appcesible/widgets/dialog_loading.dart';

class MaterialTask extends StatelessWidget {
  const MaterialTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        ScreenUtilBreakpoints.initMobileDesignSize(context);
        return const MaterialTaskApp();
      },
      tablet: (context) {
        ScreenUtilBreakpoints.initTabletDesignSize(context);
        return const MaterialTaskTab();
      },
      desktop: (context) {
        ScreenUtilBreakpoints.initWebDesignSize(context);
        return const MaterialTaskTab();
      },
    );
  }
}

abstract class MaterialTaskState<T extends StatefulWidget> extends State<T> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController studentController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  List<TaskItem> selectedMaterials = [];
  bool showSelectedMaterials = false;

  List<UserModel> teachers = [];
  List<String> classes = [];
  List<UserModel> students = [];
  List<TaskItem> materials = [];

  bool initialized = false;

  Future initializeState() async {
    if (!initialized) {
      // Get users for lists
      List<UserModel> users = await getAllUsers(false);
      for (UserModel user in users) {
        if (user.userType != 1) {
          teachers.add(user);
        } else {
          students.add(user);
        }
      }

      // Get classes
      List<ClassModel> classes = await getClasses();
      for (ClassModel classObj in classes) {
        this.classes.add(classObj.className);
      }

      // Get available materials
      List<TaskItem> items = await getAvailableItems();
      for (TaskItem item in items) {
        bool included = materials.any((material) => item.name == material.name);
        if (!included) {
          materials.add(item);
        }
      }

      initialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    teacherController.dispose();
    classController.dispose();
    studentController.dispose();
    dateTimeController.dispose();

    super.dispose();
  }

  // FORM INPUT

  void showProfesorPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
            title: 'Profesor',
            label: 'Profesor',
            elements: getTeachersNames(),
            showSearchBar: true,
            showCloseIcon: true);
      },
    );

    if (result != null) {
      setState(() {
        teacherController.text = result;
      });
    }
  }

  List<String> getTeachersNames() {
    List<String> teachersNames = [];
    for (UserModel teacher in teachers) {
      teachersNames.add(teacher.userName);
    }

    return teachersNames;
  }

  void showClasePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
            title: 'Clase', label: 'Clase', elements: classes);
      },
    );

    if (result != null) {
      setState(() {
        classController.text = result;
      });
    }
  }

  void showEstudiantePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
            title: 'Estudiante',
            label: 'Estudiante',
            elements: getStudentsNames(),
            showSearchBar: true,
            showCloseIcon: true);
      },
    );

    if (result != null) {
      setState(() {
        studentController.text = result;
      });
    }
  }

  List<String> getStudentsNames() {
    List<String> studentsNames = [];
    for (UserModel student in students) {
      studentsNames.add(student.userName);
    }

    return studentsNames;
  }

  void onMaterialSelected(String mat) {
    TaskItem material =
        materials.firstWhere((material) => material.name == mat);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuantityDialog(
          element: mat,
          maxValue: material.count,
          onQuantitySelected: (quantity) {
            setState(() {
              bool exists =
                  selectedMaterials.any((material) => material.name == mat);
              if (!exists) {
                selectedMaterials.add(TaskItem(
                    id: material.id, name: mat, count: quantity, idPicto: 0));
              }
              selectedMaterials.last.count = quantity;
              showSelectedMaterials = true;
            });
          },
        );
      },
    );
  }

  List<String> getMaterialsNames() {
    List<String> matetrialsNames = [];
    for (TaskItem material in materials) {
      matetrialsNames.add(material.name);
    }

    return matetrialsNames;
  }

  // Clear array materials
  void clearSelectedMaterials() {
    setState(() {
      selectedMaterials.clear();
      showSelectedMaterials = false;
    });
  }

  // PETITIONS

  // Creates petition
  void createOrder() {
    if (!_validateFormEntries()) {
      // Call the showErrorDialog method from the ErrorWindow class
      ErrorWindow.showErrorDialog(context, 'Debes rellenar todos los campos.');
      return;
    }

    // Show ConfirmationDialog when all fields are filled
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmationDialog(
              message: 'Se va a crear una tarea pedido. ¿Continuar?',
              onConfirm: _handleConfirmation);
        });
  }

  void _handleConfirmation() async {
    NavigatorState nav = Navigator.of(context);

    showDialog(
        context: context,
        builder: (context) {
          return const LoadingDialog();
        });

    // Create task
    TaskModel task = TaskModel(
        id: -1,
        type: 1,
        title: taskNameController.text,
        description: '',
        idPicto: -1);
    // Add all elements to the task
    task.addElements(selectedMaterials);

    // Logic to create the order
    for (var material in selectedMaterials) {
      print("Material: ${material.name}, Quantity: ${material.count}");
    }

    // Server call
    task.id = await createTask(task);

    String date = dateTimeController.text.replaceAll(',', '');
    date = date.replaceAll(':', ' ');
    await assignTask(AssignModel(
        idTask: task.id,
        idStudent: students
            .firstWhere((student) => student.userName == studentController.text)
            .id,
        dueDate: date));
    print("Finished");

    nav.pop();
    nav.pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
      return TaskListInit(
        assignTask: false,
      );
    }), (route) => false);
  }

  // Validate all forms are with content
  bool _validateFormEntries() {
    // Check if all required fields are filled
    if (selectedMaterials.isEmpty ||
        taskNameController.text.isEmpty ||
        teacherController.text.isEmpty ||
        classController.text.isEmpty ||
        studentController.text.isEmpty ||
        dateTimeController.text.isEmpty) {
      return false;
    }
    return true;
  }
}

void main() async {
  runApp(const MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('en'), // English
      Locale('es', 'ES'), // Spanish
    ],
    home: MaterialTask(),
  ));
}
