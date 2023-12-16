import 'package:appcesible/widgets/widget_top_teacher.dart';
import 'package:appcesible/screens/task_list_app.dart';
import 'package:flutter/material.dart';

class TaskListTablet extends StatefulWidget {
  final List<MyTaskData> tasks;

  const TaskListTablet({super.key, required this.tasks});

  @override
  State<TaskListTablet> createState() => _TaskListTabletState();
}

class _TaskListTabletState extends State<TaskListTablet> {
  final TextEditingController _searchController = TextEditingController();
  late List<MyTaskData> _filteredTasks;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredTasks = widget.tasks;
  }

  void _filterTasks(String searchText) {
    setState(() {
      _filteredTasks = widget.tasks.where((task) {
        return task.studentName
            .toLowerCase()
            .contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const TopMenu(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Center(
            child: Column(
              children: [
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
                          labelText: 'Buscar por alumno',
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
                        // Lógica para eliminar
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: MyTask(
                          imagePath: task.imagePath,
                          taskName: task.taskName,
                          studentName: task.studentName,
                          state: task.state,
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
}

// Class that creates a box with text inside
class MyTask extends StatelessWidget {
  final String imagePath;
  final String taskName;
  final String studentName;
  final String state;

  const MyTask({
    super.key,
    required this.imagePath,
    required this.taskName,
    required this.studentName,
    required this.state,
  });

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
          imageWidget(image: imagePath),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(fontSize: 15.0),
                ),
                const SizedBox(height: 20),
                Text(
                  studentName,
                  style: const TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp),
            onPressed: () {
              // Lógica del botón
            },
          ),
        ],
      ),
    );
  }

  // Widged that shows an image
  Widget imageWidget({required String image}) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
