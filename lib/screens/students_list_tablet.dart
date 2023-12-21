import 'package:appcesible/screens/info_student_tab.dart';
import 'package:flutter/material.dart';
import 'package:appcesible/screens/students_list.dart';
import 'package:appcesible/widgets/widget_top_teacher.dart';

class StudentListTablet extends StatefulWidget {
  final List<MyStudentData> tasks;
  final bool assignTask;

  StudentListTablet({Key? key, required this.tasks, required this.assignTask})
      : super(key: key);

  @override
  State<StudentListTablet> createState() => _StudentListTabletState();
}

class _StudentListTabletState extends State<StudentListTablet> {
  final TextEditingController _searchController = TextEditingController();
  late List<MyStudentData> _filteredTasks;
  bool _isSearching = false;
  bool _isDeleting = false;

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
          return task.studentName
              .toLowerCase()
              .contains(searchText.toLowerCase());
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
                          labelText: "Buscar por alumno",
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

                        MyStudent.setDeleting(_isDeleting);
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
                      MyStudentData task = _filteredTasks[index];
                      return MyStudent(
                        imagePath: task.imageStudent,
                        studentName: task.studentName,
                        clase: task.clase,
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
    return const Text(
      'Lista de Alumnos',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Class that creates a box with text inside
class MyStudent extends StatelessWidget {
  final String imagePath;
  final String clase;
  final String studentName;

  static bool _isDeleting = false;

  const MyStudent({
    super.key,
    required this.imagePath,
    required this.clase,
    required this.studentName,
  });

  static void setDeleting(bool delete) {
    _isDeleting = delete;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(189, 189, 189, 1);

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
                  studentName,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.020),
                ),
                const SizedBox(height: 20),
                Text(
                  clase,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.020),
                ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentInformationTablet()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Widged that shows an image
  Widget imageWidget({required String image}) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
