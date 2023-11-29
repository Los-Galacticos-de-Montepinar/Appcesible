import 'package:appcesible/widgets/confirmation_window.dart';
import 'package:appcesible/widgets/quantity_dialog.dart';
import 'package:appcesible/widgets/seleccionar_estudiante_window.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:appcesible/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/widgets/my_button.dart';
import 'form_drop_down.dart';
import 'form_entry.dart';

class MaterialTaskTab extends StatefulWidget {
  const MaterialTaskTab({Key? key}) : super(key: key);

  @override
  _MaterialTaskTabState createState() => _MaterialTaskTabState();
}

class _MaterialTaskTabState extends State<MaterialTaskTab> {
  List<String> selectedMaterials = [];
  Map<String, int> materialQuantities = {};
  bool showSelectedMaterials = false;

  TextEditingController controllerNombreTarea = TextEditingController();
  TextEditingController controllerProfesor = TextEditingController();
  TextEditingController controllerClase = TextEditingController();
  TextEditingController controllerEstudiante = TextEditingController();
  TextEditingController controllerFecha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: const TopMenu(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 225,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Center(
                    child: Text(
                      'Nueva Tarea Material',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Información General',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MaterialFormEntry(
                    name: 'Nombre Tarea',
                    typeData: 1,
                    controller: controllerNombreTarea),
                MaterialFormEntry(
                    name: 'Profesor',
                    typeData: 1,
                    controller: controllerProfesor),
                MaterialFormEntry(
                    name: 'Clase', typeData: 1, controller: controllerClase),
                MaterialFormEntry(
                    name: 'Estudiante',
                    typeData: 4,
                    controller: controllerEstudiante,
                    onTap: _showEstudiantePopup),
                MaterialFormEntry(
                    name: 'Fecha', typeData: 2, controller: controllerFecha),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Pedido',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MaterialFormEntryWithDropdown(
                    name: 'Tipo Material',
                    onMaterialSelected: _onMaterialSelected),
                const SizedBox(height: 20),
                if (showSelectedMaterials)
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Material Seleccionado',
                              style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _clearSelectedMaterials,
                              icon: const Icon(Icons.delete),
                              label: const Text('Limpiar'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        for (var entry in materialQuantities.entries)
                          Text(
                              "Tipo: ${entry.key}. \nCantidad: ${entry.value}\n"),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                const SizedBox(height: 0),
                MyButton(buttonText: 'Crear Pedido', onPressed: _createOrder),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onMaterialSelected(String material) {
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
  void _createOrder() {
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
  void _clearSelectedMaterials() {
    setState(() {
      selectedMaterials.clear();
      materialQuantities.clear();
      showSelectedMaterials = false;
    });
  }

  void _showEstudiantePopup() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SeleccionarEstudianteWindow();
      },
    );

    if (result != null) {
      setState(() {
        controllerEstudiante.text = result;
      });
    }
  }
}
