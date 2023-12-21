import 'package:flutter/material.dart';

import 'package:appcesible/widgets/widget_top_teacher.dart';

class TaskListMobile extends StatefulWidget {
  final List<MyTaskData> tasks;

  const TaskListMobile({super.key, required this.tasks});

  @override
  State<TaskListMobile> createState() => _TaskListMobileState();
}

class _TaskListMobileState extends State<TaskListMobile> {
  final TextEditingController _searchController = TextEditingController();
  late List<MyTaskData> _filteredTasks;
  bool _isSearching = false;
  bool _isDeleting = false;
  bool _assignTask = true;
  String imagePath = "PRUEBA";

  @override
  void initState() {
    super.initState();
    _filteredTasks = widget.tasks;
  }

  void _filterTasks(String searchText) {
    setState(() {
      _filteredTasks = widget.tasks.where((task) {
        if (_assignTask) {
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
                const SizedBox(height: 10.0),
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
                          labelText: _assignTask
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
                  child: ListView.builder(
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      MyTaskData task = _filteredTasks[index];
                      if (_assignTask) {
                        imagePath = task.imagePath;
                      } else {
                        imagePath = task.imageStudent;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: MyTask(
                          imagePath: imagePath,
                          taskName: task.taskName,
                          studentName: task.studentName,
                          state: task.state,
                          assignTask: _assignTask,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      _assignTask ? 'Asignación de tareas' : 'Lista de tareas',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Auxiliar class for task data
class MyTaskData {
  final String imagePath;
  final String imageStudent;
  final String taskName;
  final String studentName;
  final String state;

  MyTaskData({
    required this.imagePath,
    required this.imageStudent,
    required this.taskName,
    required this.studentName,
    required this.state,
  });
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
      height: 120,
      width: 200,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        children: [
          imageWidget(image: imagePath, assignTask: assignTask),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(fontSize: 20.0),
                ),
                if (!assignTask) ...[
                  const SizedBox(height: 20),
                  Text(
                    studentName,
                    style: const TextStyle(fontSize: 20.0),
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
              } else {}
            },
          ),
        ],
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
