// SCREEEN TO ADD A STEP TO THE TASK - Phone Version
// Autor: Alejandro Sanchez Rodríguez

import 'package:flutter/material.dart';
import 'package:appcesible/widgets/top_menu.dart';

class CreateStepMobile extends StatefulWidget {
  const CreateStepMobile({Key? key}) : super(key: key);

  @override
  _CreateStepMobileState createState() => _CreateStepMobileState();
}

class _CreateStepMobileState extends State<CreateStepMobile> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  String _mediaPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 70,
          title: const Text(
            'AppCesible',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 220, 131),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 20.0, width: 20.0),
                Container(
                  width: 330,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      const MyStyledBox(),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _nombreController,
                        style: const TextStyle(fontSize: 15.0),
                        decoration: const InputDecoration(
                          labelText: 'Nombre Paso',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _descripcionController,
                        style: const TextStyle(fontSize: 15.0),
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      imageWidget(image: 'assets/images/addPicture.png'),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            fixedSize: MaterialStateProperty.all(
                                const Size(200.0, 60.0)),
                          ),
                          onPressed: () {
                            _onFormSubmit();
                          },
                          child: const Text('Crear paso'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )); 
  }

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


  void _onFormSubmit() {
    // Valide if the fields are empty
    if (_nombreController.text.isEmpty || _descripcionController.text.isEmpty) {
      // Show notification
      _showEmptyFieldsNotification();
    } else {
      // If the fields are not empty, proceed with the process
      Navigator.pop(
        context,
        {
          'nombrePaso': _nombreController.text,
          'descripcion': _descripcionController.text,
        },
      );
    }
  }

  // Function that appear if you dont fill the form fields
  void _showEmptyFieldsNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Por favor, rellene todos los campos.'),
      ),
    );
  }
}

// Class that creates a box with text inside
class MyStyledBox extends StatelessWidget {
  const MyStyledBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
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
        'Crear Nueva Paso',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}