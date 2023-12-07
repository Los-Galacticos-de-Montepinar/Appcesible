import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:appcesible/models/task_model.dart';
import 'package:appcesible/models/user_model.dart';

import 'package:appcesible/services/task_service.dart';
import 'package:appcesible/services/user_service.dart';

import 'package:appcesible/screens/create_material_task_app.dart';
import 'package:appcesible/screens/create_material_task_tab.dart';
import 'package:appcesible/screens/screen_util_breakpoints.dart';

import 'package:appcesible/widgets/dialog_with_search_bar.dart';
import 'package:appcesible/widgets/quantity_dialog.dart';
import 'package:appcesible/widgets/error.dart';
import 'package:appcesible/widgets/confirmation_window.dart';

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
  TextEditingController controllerNombreTarea = TextEditingController();
  TextEditingController controllerProfesor = TextEditingController();
  TextEditingController controllerClase = TextEditingController();
  TextEditingController controllerEstudiante = TextEditingController();
  TextEditingController controllerFecha = TextEditingController();

  TaskModel task = TaskModel(
    id: -1,
    type: 1,
    title: '',
    description: '',
    idPicto: -1
  );
  List<TaskItem> selectedMaterials = [];
  bool showSelectedMaterials = false;

  List<String> teachers = [];
  List<String> classes = [];
  List<String> students = [];
  List<String> materials = [];

  void _initializeState() async {
    // Get users for lists
    List<UserModel> users = await getAllUsers();
    for (UserModel user in users) {
      if (user.userType != 1) {
        teachers.add(user.userName);
      }
      else {
        students.add(user.userName);
      }
    }

    // Get available materials
    List<TaskItem> items = await getAvailableItems();
    for (TaskItem item in items) {
      materials.add(item.name);
    }
  }

  @override
  void initState() {
    _initializeState();
    super.initState();
  }

  @override
  void dispose() {
    controllerNombreTarea.dispose();
    controllerProfesor.dispose();
    controllerClase.dispose();

    super.dispose();
  }

  // FORM INPUT

  void showProfesorPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
          elements: teachers
        );
      },
    );

    if (result != null) {
      setState(() {
        controllerProfesor.text = result;
      });
    }
  }

  void showClasePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DialogWithSearchBar(
          elements: [
          'Clase1',
          'Clase2',
          'Clase3',
          'Clase4',
          'Clase5',
          'Clase6',
          'Clase7',
          'Clase8',
          'Clase9',
          'Clase10',
          'Clase11',
          'Clase12',
          'Clase13',
          'Clase14',
          'Clase15',
          'Clase16',
        ]);
      },
    );

    if (result != null) {
      setState(() {
        controllerClase.text = result;
      });
    }
  }

  void showEstudiantePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWithSearchBar(
          elements: students
        );
      },
    );

    if (result != null) {
      setState(() {
        controllerEstudiante.text = result;
      });
    }
  }

  void onMaterialSelected(String material) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return QuantityDialog(
          element: material,
          onQuantitySelected: (quantity) {
            setState(() {
              bool exists = selectedMaterials.any((element) => element.name == material);
              if (!exists) {
                selectedMaterials.add(TaskItem(
                  id: -1,
                  name: material,
                  quantity: quantity
                ));
              }
              selectedMaterials.last.quantity = quantity;
              showSelectedMaterials = true;
            });
          },
        );
      },
    );
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

    // Show ConfirmationWindow when all fields are filled
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationWindow(
          message: 'Se va a crear una tarea pedido. ¿Continuar?',
          onConfirm: _handleConfirmation
        );
      }
    );
  }

  void _handleConfirmation() {
    // Add all elements to the task
    task.addElements(selectedMaterials);

    // Logic to create the order
    for (var material in selectedMaterials) {
      print("Material: ${material.name}, Quantity: ${material.quantity}");
    }

    // Server call
    createTask(task);
    print("Finished");
  }

  // Validate all forms are with content
  bool _validateFormEntries() {
    // Check if all required fields are filled
    if (selectedMaterials.isEmpty ||
        controllerNombreTarea.text.isEmpty ||
        controllerProfesor.text.isEmpty ||
        controllerClase.text.isEmpty ||
        controllerEstudiante.text.isEmpty ||
        controllerFecha.text.isEmpty) {
      return false;
    }
    return true;
  }
}

void main() {
  runApp(const MaterialApp(
    home: MaterialTask(),
  ));
}
