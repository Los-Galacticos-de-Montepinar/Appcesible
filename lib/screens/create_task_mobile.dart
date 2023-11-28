// SCREEEN TO CREATE A TASK - Phone Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/screens/create_step_task_mobile.dart';

class CreateTaskMobile extends StatefulWidget {
  const CreateTaskMobile({Key? key}) : super(key: key);

  @override
  _CreateTaskMobileState createState() => _CreateTaskMobileState();
}

class _CreateTaskMobileState extends State<CreateTaskMobile> {

  // Auxiliary variables
  String _selectedTipo = '';
  String _mediaPath = '';

  // Variables to store data
  String _nombrePaso = '';
  String _paso = '';
  String _descripcion = '';

  // New list to save the steps
  List<String> listaPasos = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TopMenu(),
        body: Center(
          child: FittedBox(
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                  width: 20.0,
                ),
                const MyStyledBox(),
                const SizedBox(width: 20.0),
                _createTask(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget that shows an image
  Widget imageWidget({required String image}) {
    return GestureDetector(
      onTap: () {
        _showMediaPickerDialog();
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: _mediaPath.isNotEmpty
            ? const Icon(Icons.play_circle_fill, size: 50, color: Colors.white)
            : null,
      ),
    );
  }

  // Widget that create the task
  Widget _createTask() {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          const TextField(
            style: TextStyle(fontSize: 15.0),
            decoration: InputDecoration(
              labelText: 'Nombre de la tarea',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            maxLines: 5,
            style: TextStyle(fontSize: 15.0),
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 320,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                // Navigate to the second screen and wait for return data
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateStepMobile()),
                );

                // Process the return data and update the first screen if necessary
                if (result != null) {
                  setState(() {
                    // Update the first screen with data from the second form
                    // You can use the data from 'result' as needed
                    _nombrePaso = result['nombrePaso'];
                    _descripcion = result['descripcion'];

                    String nuevoPaso =
                        'Paso ${listaPasos.length + 1}: $_nombrePaso';
                    listaPasos.add(nuevoPaso);
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 158, 155, 155)),
                fixedSize: MaterialStateProperty.all(const Size(200.0, 60.0)),
              ),
              child: const Text('Añadir Paso'),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            height: 150,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 142, 139, 139),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: listaPasos.isEmpty
                ? const Center(
                    child: Text(
                    'No hay pasos añadidos',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 142, 139, 139)),
                  ))
                : ListView.builder(
                    itemCount: listaPasos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(listaPasos[index]),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 20.0),
          imageWidget(image: 'assets/images/addPicture.png'),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 400,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Logic Button
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                fixedSize: MaterialStateProperty.all(const Size(200.0, 60.0)),
              ),
              child: const Text('Crear Tarea'),
            ),
          )
        ],
      ),
    );
  }

// Displays a notification to select a video or an image
  void _showMediaPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Multimedia'),
          content: SizedBox(
            height: 120.0, 
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Seleccionar Imagen'),
                  onTap: () {
                    // Logic for selecting image
                    Navigator.pop(context);
                    _pickImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Seleccionar Video'),
                  onTap: () {
                    // Logic for selecting video
                    Navigator.pop(context);
                    _pickVideo();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

    void _pickImage() {
    // Logic for the selecting image
    }

    void _pickVideo() {
      // Logic for the selecting video
    }
}

// Class that creates a box with text inside
class MyStyledBox extends StatelessWidget {

  const MyStyledBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        border: Border.all(
          color: Colors.black,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: const Text(
        'Crear Nueva Tarea',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
