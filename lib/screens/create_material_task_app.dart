import 'package:flutter/material.dart';
import 'package:appcesible/widgets/top_menu.dart';

import 'form_drop_down.dart';
import 'form_entry.dart';

class MaterialTaskApp extends StatefulWidget {
  const MaterialTaskApp({super.key});

  @override
  _MaterialTaskAppState createState() => _MaterialTaskAppState();
}

class _MaterialTaskAppState extends State<MaterialTaskApp> {
  List<String> selectedMaterials = []; // Array para almacenar los materiales
  bool showSelectedMaterials =
      false; // Variable para controlar la visibilidad del contenedor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    border: Border.all(
                        color: Colors
                            .black), // Añade esta línea para el borde negro
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
                  alignment:
                      Alignment.topLeft, // Añadida esta línea para centrar
                  child: const Text(
                    'Datos generales',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const MaterialFormEntry(name: 'Nombre de Tarea', typeData: 1),
                const MaterialFormEntry(name: 'Cantidad', typeData: 0),
                const MaterialFormEntry(name: 'Profesor', typeData: 1),
                const MaterialFormEntry(name: 'Aula', typeData: 1),
                const MaterialFormEntry(name: 'Alumno', typeData: 1),
                const MaterialFormEntry(name: 'Fecha', typeData: 1),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment:
                      Alignment.topLeft, // Añadida esta línea para centrar
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
                    name: 'Tipo de Material',
                    onMaterialSelected: _onMaterialSelected),
                const SizedBox(height: 20),
                // Contenedor para mostrar los materiales seleccionados
                if (showSelectedMaterials)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Materiales seleccionados:"),
                      const SizedBox(height: 5),
                      Text(selectedMaterials.join(
                          ", ")), // Muestra los materiales seleccionados separados por coma
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Función para manejar la selección de materiales
  void _onMaterialSelected(String material) {
    setState(() {
      if (!selectedMaterials.contains(material)) {
        selectedMaterials.add(material);
        if (!showSelectedMaterials) {
          showSelectedMaterials = true;
        }
      }
    });
  }
}

class ImageWidget extends StatelessWidget {
  final String image;

  const ImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
