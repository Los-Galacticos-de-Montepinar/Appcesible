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
  ];
  List<String> estudiantesFiltrados = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    estudiantesFiltrados = List.from(estudiantes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Buscar Estudiante',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8.0
          ),
          TextField(
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
          const SizedBox(
            height: 8.0
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero, // Ajuste el espacio interno
      backgroundColor: Colors.white,
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          controller: ScrollController(),
          shrinkWrap: true,
          itemCount: estudiantesFiltrados.length,
          itemBuilder: (context, index) {
            return _buildEstudianteTile(estudiantesFiltrados[index]);
          },
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
