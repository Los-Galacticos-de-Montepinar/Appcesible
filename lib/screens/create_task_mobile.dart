import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class CreateTaskMobile extends StatefulWidget {
  const CreateTaskMobile({Key? key}) : super(key: key);

  @override
  _CreateTaskMobileState createState() => _CreateTaskMobileState();
}

class _CreateTaskMobileState extends State<CreateTaskMobile> {
  String _selectedTipo = ''; // Variable para almacenar la opción seleccionada
  String _mediaPath = ''; // Ruta del archivo multimedia seleccionado

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const TopMenu(),
        body: Center(
          child: FittedBox(
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                  width: 20.0,
                ),
                MyStyledBox(),
                const SizedBox(width: 20.0),
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _buildForm() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Nombre de la tarea',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            maxLines: 5,
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Clase',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Alumno',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20.0),
          const Text('Pictograma'),
          const SizedBox(height: 20.0),
          imageWidget(image: 'assets/images/addPicture.png'),
          const SizedBox(height: 20.0),
          Container(
            width: 300,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Aquí puedes manejar la lógica cuando se presiona el botón
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

  void _showMediaPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Multimedia'),
          content: SizedBox(
            height: 100.0, // Ajusta la altura según tus necesidades
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Seleccionar Imagen'),
                  onTap: () {
                    // Lógica para seleccionar imagen
                    Navigator.pop(context);
                    _pickImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Seleccionar Video'),
                  onTap: () {
                    // Lógica para seleccionar video
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
    // Lógica para seleccionar imagen
    // Puedes utilizar plugins como image_picker para implementar la selección de imágenes
    // y actualizar _mediaPath con la ruta de la imagen seleccionada.
  }

  void _pickVideo() {
    // Lógica para seleccionar video
    // Puedes utilizar plugins como image_picker para implementar la selección de videos
    // y actualizar _mediaPath con la ruta del video seleccionado.
  }
}

class MyStyledBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
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












































/*
import 'package:appcesible/widgets/top_menu.dart';
import 'package:flutter/material.dart';

class CreateTaskMobile extends StatelessWidget {
  const CreateTaskMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const TopMenu(),
        body: Center(
          child: FittedBox(
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                MyStyledBox(),
                const SizedBox(height: 0.0),
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageWidget({required String image}) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(  
              labelText: 'Nombre de la tarea',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            maxLines: 5,
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Tipo (Fija, Diaria)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Clase',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15.0),
          const TextField(
            style: TextStyle(fontSize: 12.0),
            decoration: InputDecoration(
              labelText: 'Alumno',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: 300,
            height: 50,
            child: ElevatedButton(
              
              onPressed: () {
                // Aquí puedes manejar la lógica cuando se presiona el botón
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Cambia el color de fondo del botón
                fixedSize: MaterialStateProperty.all(const Size(200.0, 60.0)),
              ),
              child: const Text('Crear Tarea'),
            ),
          )
        ],
      ),
    );
  }
}

class MyStyledBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
*/
