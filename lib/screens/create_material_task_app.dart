import 'package:flutter/material.dart';

import 'package:appcesible/screens/create_material_task.dart';
import 'package:appcesible/widgets/top_menu.dart';
import 'package:appcesible/widgets/my_button.dart';
import 'package:appcesible/widgets/form_entry.dart';
import 'package:appcesible/widgets/form_drop_down.dart';

class MaterialTaskApp extends StatefulWidget {
  const MaterialTaskApp({super.key});

  @override
  State<MaterialTaskApp> createState() => _MaterialTaskAppState();
}

class _MaterialTaskAppState extends MaterialTaskState<MaterialTaskApp> {
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
                  controller: controllerNombreTarea
                ),
                MaterialFormEntry(
                  name: 'Profesor',
                  typeData: 1,
                  controller: controllerProfesor
                ),
                MaterialFormEntry(
                  name: 'Clase',
                  typeData: 1,
                  controller: controllerClase
                ),
                MaterialFormEntry(
                  name: 'Estudiante',
                  typeData: 4,
                  controller: controllerEstudiante,
                  onTap: showEstudiantePopup
                ),
                MaterialFormEntry(
                  name: 'Fecha',
                  typeData: 2,
                  controller: controllerFecha
                ),
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
                  onMaterialSelected: onMaterialSelected,
                  elements: const ["Material 1", "Material 2", "Material 3"],
                ),
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
                              onPressed: clearSelectedMaterials,
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
                MyButton(buttonText: 'Crear Pedido', onPressed: createOrder),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
