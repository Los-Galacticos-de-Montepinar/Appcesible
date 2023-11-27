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
  bool showSelectedMaterials = false;

  TextEditingController controllerNombreTarea = TextEditingController();
  TextEditingController controllerCantidad = TextEditingController();
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
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                MaterialFormEntry(
                    name: 'Nombre Tarea',
                    typeData: 1,
                    controller: controllerNombreTarea),
                MaterialFormEntry(
                    name: 'Cantidad',
                    typeData: 0,
                    controller: controllerCantidad),
                MaterialFormEntry(
                    name: 'Profesor',
                    typeData: 1,
                    controller: controllerProfesor),
                MaterialFormEntry(
                    name: 'Clase', typeData: 1, controller: controllerClase),
                MaterialFormEntry(
                    name: 'Estudiante',
                    typeData: 1,
                    controller: controllerEstudiante),
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
                      fontWeight: FontWeight.normal,
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
                        const Text("Materiales Seleccionados:"),
                        const SizedBox(height: 5),
                        Text(selectedMaterials.join(", ")),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                const SizedBox(height: 30),
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
    setState(() {
      if (!selectedMaterials.contains(material)) {
        selectedMaterials.add(material);
        showSelectedMaterials = true;
      }
    });
  }

  void _createOrder() {
    if (!_validateFormEntries()) {
      // Call the showErrorDialog method from the ErrorWindow class with red color (#FF0000)
      ErrorWindow.showErrorDialog(context, 'Debes rellenar todos los campos.');
      return;
    }

    // Logic to create the order
    print("Order Created: ");
    for (var material in selectedMaterials) {
      print("Material: $material");
    }
  }

  bool _validateFormEntries() {
    // Check if all required fields are filled
    // You can adjust this logic based on your specific requirements
    if (selectedMaterials.isEmpty ||
        controllerNombreTarea.text.isEmpty ||
        controllerCantidad.text.isEmpty ||
        controllerProfesor.text.isEmpty ||
        controllerClase.text.isEmpty ||
        controllerEstudiante.text.isEmpty ||
        controllerFecha.text.isEmpty) {
      return false;
    }
    return true;
  }
}
