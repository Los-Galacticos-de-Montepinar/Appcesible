import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
  List<String> selectedMaterials = [];
  Map<String, int> materialQuantities = {};
  bool showSelectedMaterials = false;

  TextEditingController controllerNombreTarea = TextEditingController();
  TextEditingController controllerProfesor = TextEditingController();
  TextEditingController controllerClase = TextEditingController();
  TextEditingController controllerEstudiante = TextEditingController();
  TextEditingController controllerFecha = TextEditingController();

  @override
  void dispose() {
    controllerNombreTarea.dispose();
    controllerProfesor.dispose();
    controllerClase.dispose();

    super.dispose();
  }

  // Gestión de inputs

  void showProfesorPopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const DialogWithSearchBar(
          elements: [
          'Profesor1',
          'Profesor2',
          'Profesor3',
          'Profesor4',
          'Profesor5',
          'Profesor6',
          'Profesor7',
          'Profesor8',
          'Profesor9',
          'Profesor10',
          'Profesor11',
          'Profesor12',
          'Profesor13',
          'Profesor14',
          'Profesor15',
          'Profesor16',
        ]);
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
        return const DialogWithSearchBar(
          elements: [
          'Estudiante1',
          'Estudiante2',
          'Estudiante3',
          'Estudiante4',
          'Estudiante5',
          'Estudiante6',
          'Estudiante7',
          'Estudiante8',
          'Estudiante9',
          'Estudiante10',
          'Estudiante11',
          'Estudiante12',
          'Estudiante13',
          'Estudiante14',
          'Estudiante15',
          'Estudiante16',
        ]);
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
          material: material,
          onQuantitySelected: (quantity) {
            setState(() {
              if (!selectedMaterials.contains(material)) {
                selectedMaterials.add(material);
              }
              materialQuantities[material] = quantity;
              showSelectedMaterials = true;
            });
          },
        );
      },
    );
  }

  // Crea el pedido
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
          return ConfirmationWindow(onConfirm: _handleConfirmation);
        });
  }

  void _handleConfirmation() {
    // Logic to create the order
    print("Pedido Creado: ");
    for (var entry in materialQuantities.entries) {
      print("Material: ${entry.key}, Quantity: ${entry.value}");
    }
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

  // Clear array materials
  void clearSelectedMaterials() {
    setState(() {
      selectedMaterials.clear();
      materialQuantities.clear();
      showSelectedMaterials = false;
    });
  }

  void submitForm() {

  }
}

void main() {
  runApp(const MaterialApp(
    home: MaterialTask(),
  ));
}
