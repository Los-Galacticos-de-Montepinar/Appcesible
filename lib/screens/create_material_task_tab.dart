import 'package:appcesible/screens/home_teacher.dart';
import 'package:appcesible/widgets/dialog_confirm.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/screens/create_material_task.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:appcesible/widgets/input_dropdown.dart';
import 'package:appcesible/widgets/input_custom.dart';
import 'package:appcesible/widgets/dialog_loading.dart';
import 'package:appcesible/widgets/button.dart';

class MaterialTaskTab extends StatefulWidget {
  const MaterialTaskTab({super.key});

  @override
  State<MaterialTaskTab> createState() => _MaterialTaskTabState();
}

class _MaterialTaskTabState extends MaterialTaskState<MaterialTaskTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeState(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: TopMenu(onHomeTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                      message:
                          '¿Está seguro de que quiere abandonar el proceso?\nLos datos introducidos hasta el momento se perderán',
                      onConfirm: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return const TeacherHome();
                        }), (route) => false);
                      });
                });
          }),
          body: (initialized ||
                  snapshot.connectionState == ConnectionState.done)
              ? SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Texto "Nueva Tarea Material" en el medio
                      Container(
                        width: double.maxFinite,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
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
                      const SizedBox(height: 20.0),
                      // Contenido de las dos columnas
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Columna Izquierda
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 20.0, left: 5.0),
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
                                FormEntry(
                                  name: 'Nombre Tarea',
                                  typeData: 1,
                                  controller: taskNameController,
                                ),
                                const SizedBox(height: 8.0),
                                FormEntry(
                                  name: 'Profesor',
                                  typeData: 4,
                                  controller: teacherController,
                                  onTap: showProfesorPopup,
                                ),
                                const SizedBox(height: 8.0),
                                FormEntry(
                                  name: 'Clase',
                                  typeData: 4,
                                  controller: classController,
                                  onTap: showClasePopup,
                                ),
                                const SizedBox(height: 8.0),
                                FormEntry(
                                  name: 'Estudiante',
                                  typeData: 4,
                                  controller: studentController,
                                  onTap: showEstudiantePopup,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          // Columna Derecha
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 10.0, left: 5.0),
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
                                FormEntry(
                                  name: 'Fecha',
                                  typeData: 2,
                                  controller: dateTimeController,
                                ),
                                const SizedBox(height: 8.0),
                                InputDropdown(
                                  name: 'Tipo Material',
                                  onElementSelected: onMaterialSelected,
                                  elements: getMaterialsNames(),
                                ),
                                const SizedBox(height: 20.0),
                                if (showSelectedMaterials)
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              style: const ButtonStyle(
                                                iconColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.black),
                                              ),
                                              icon: const Icon(Icons.delete),
                                              label: const Text(
                                                'Limpiar',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        for (var material in selectedMaterials)
                                          Text(
                                              'Material: ${material.name}\nCantidad: ${material.count}\n'),
                                        const SizedBox(height: 20.0),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Botón "Crear Pedido" en el medio
                      Align(
                        alignment: Alignment.center,
                        child: ActionButton(
                            text: 'Crear Pedido',
                            type: 1,
                            onPressed: createOrder),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                )
              : const LoadingDialog(),
        );
      },
    );
  }
}
