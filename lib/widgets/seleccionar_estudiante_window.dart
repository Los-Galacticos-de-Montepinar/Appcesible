import 'package:flutter/material.dart';

class SeleccionarEstudianteWindow extends StatefulWidget {
  const SeleccionarEstudianteWindow({super.key});

  @override
  State<SeleccionarEstudianteWindow> createState() => _SeleccionarEstudianteWindowState();
}

class _SeleccionarEstudianteWindowState extends State<SeleccionarEstudianteWindow> {
  List<String> estudiantes = [
    'Estudiante1',
    'Estudiante2',
    'Estudiante3',
    'Estudiante4'
  ];
  List<String> estudiantesFiltrados = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    estudiantesFiltrados = List.from(estudiantes);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8.0), // Ajuste el espacio interno
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Seleccionar Estudiante',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Cerrar la ventana emergente
                    },
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      8.0), // Ajuste el espacio entre el título y el campo de búsqueda
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      estudiantesFiltrados = estudiantes
                          .where((estudiante) => estudiante
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Buscar Estudiante',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search), // Agrega el icono de lupa
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: estudiantesFiltrados.length,
                itemBuilder: (context, index) {
                  return _buildEstudianteTile(estudiantesFiltrados[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstudianteTile(String estudiante) {
    return ListTile(
      leading: const SizedBox(
        width: 40,
        height: 40,
        child: Icon(Icons.account_circle, size: 40, color: Colors.black),
      ),
      title: Text(estudiante),
      onTap: () {
        Navigator.pop(context, estudiante);
      },
    );
  }
}
