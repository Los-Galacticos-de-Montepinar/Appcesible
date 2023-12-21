import 'package:appcesible/screens/assign_fixed_task.dart';
import 'package:appcesible/screens/info_task.dart';
import 'package:appcesible/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/screens/task_list.dart';

import 'package:appcesible/widgets/widget_top_teacher.dart';

class TaskListTablet extends StatefulWidget {
  final List<MyTaskData> tasks;
  final bool assignTask;

  TaskListTablet({Key? key, required this.tasks, required this.assignTask})
      : super(key: key);

  @override
  State<TaskListTablet> createState() => _TaskListTabletState();
}

class _TaskListTabletState extends State<TaskListTablet> {
  final TextEditingController _searchController = TextEditingController();
  late List<MyTaskData> _filteredTasks;
  bool _isSearching = false;
  bool _isDeleting = false;
  String imagePath = "PRUEBA";

  @override
  void initState() {
    super.initState();
    _filteredTasks = widget.tasks;
  }

  void _filterTasks(String searchText) {
    setState(() {
      _filteredTasks = widget.tasks.where((task) {
        if (widget.assignTask) {
          // If _assignTask is true, filter by taskName
          return task.taskName.toLowerCase().contains(searchText.toLowerCase());
        } else {
          // If _assignTask is false, filter by studentName
          return task.studentName
              .toLowerCase()
              .contains(searchText.toLowerCase());
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const TopMenu(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: _buildHeaderText()),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        // Lógica para agregar
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          _filterTasks(value);
                          setState(() {
                            _isSearching = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: widget.assignTask
                              ? "Buscar por tarea"
                              : "Buscar por alumno",
                          border: const OutlineInputBorder(),
                          prefixIcon: _isSearching
                              ? IconButton(
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterTasks('');
                                    setState(() {
                                      _isSearching = false;
                                    });
                                  },
                                )
                              : const Icon(Icons.search),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _isDeleting = !_isDeleting;
                        });

                        MyTask.setDeleting(_isDeleting);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 200 / 65,
                    ),
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      MyTaskData task = _filteredTasks[index];
                      if (widget.assignTask) {
                        imagePath = task.imagePath;
                      } else {
                        imagePath = task.imageStudent;
                      }
                      return MyTask(
                        imagePath: imagePath,
                        taskName: task.taskName,
                        studentName: task.studentName,
                        state: task.state,
                        assignTask: widget.assignTask,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      widget.assignTask ? 'Asignación de tareas' : 'Lista de tareas',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Class that creates a box with text inside
class MyTask extends StatelessWidget {
  final String imagePath;
  final String taskName;
  final String studentName;
  final String state;
  final bool assignTask;

  static bool _isDeleting = false;

  const MyTask({
    super.key,
    required this.imagePath,
    required this.taskName,
    required this.studentName,
    required this.state,
    required this.assignTask,
  });

  static void setDeleting(bool delete) {
    _isDeleting = delete;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;

    // Lógica para determinar el color de fondo según el estado
    if (state == 'not finished') {
      backgroundColor = const Color.fromRGBO(189, 189, 189, 1); // Color actual
    } else if (state == 'done') {
      backgroundColor = const Color.fromARGB(255, 126, 229, 130); // Color verde
    } else if (state == 'not done') {
      backgroundColor = const Color.fromARGB(255, 223, 102, 93); // Color rojo
    } else {
      backgroundColor = const Color.fromRGBO(189, 189, 189, 1); // Por defecto
    }

    if (assignTask) {
      backgroundColor = const Color.fromRGBO(
          189, 189, 189, 1); // Fondo gris para asignación de tareas
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinea la fila en la parte superior
          children: [
            imageWidget(image: imagePath, assignTask: assignTask),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.020),
                    maxLines: 1, // Limita el número de líneas a 1
                    overflow: TextOverflow
                        .ellipsis, // Agrega puntos suspensivos si el texto es demasiado largo
                  ),
                  if (!assignTask) ...[
                    const SizedBox(height: 10), // Espacio más pequeño
                    Text(
                      studentName,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width *
                              0.020), // Tamaño de fuente ligeramente más pequeño
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]
                ],
              ),
            ),
            IconButton(
              icon: (_isDeleting)
                  ? const Icon(Icons.delete)
                  : const Icon(Icons.arrow_forward_ios_sharp),
              onPressed: () {
                if (_isDeleting) {
                } else {
                  if (assignTask) {
                    // Assign task true
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const TaskAsign();
                    }));
                  } else {
                    // Assign task false
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const TaskInformation();
                    }));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widged that shows an image
  Widget imageWidget({required String image, required bool assignTask}) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          border: assignTask
              ? Border.all(
                  color: Colors.black,
                  width: 1,
                )
              : Border.all(
                  color: Colors.black,
                  width: 2,
                ),
          borderRadius: assignTask
              ? BorderRadius.circular(0)
              : BorderRadius.circular(100),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
