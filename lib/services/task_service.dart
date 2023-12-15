import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/task_model.dart';
import 'package:appcesible/models/assign_model.dart';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = 'localhost:8080';
String _baseAddress = '100.70.70.131:8080';  // IP privada
// String _baseAddress = '100.99.220.41:8080';  // IP ordenador

// CREATE

Future<int> createTask(TaskModel task) async {
  final taskResponse = await http.post(
    Uri.http(_baseAddress, (task.type == 0) ? '/task/new' : '/task/petition/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'title': task.title,
      'desc': task.description
    }),
  );

  if (taskResponse.statusCode == 200) {
    int id = int.parse(utf8.decode(taskResponse.bodyBytes));
    print(id);

    for (TaskElement element in task.elements) {
      final elemResponse = await http.post(
        Uri.http(
          _baseAddress,
          (task.type == 0)
            ? 'task/step/new'
            : 'task/petition/$id/item/new'
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: (task.type == 0)
          ? jsonEncode(<String, dynamic>{
              'taskId': id,
              'desc': (element as Step).description,
              'media': element.media,
              'order': element.stepNumber,
            })
          : jsonEncode(<String, dynamic>{
              'item': (element as TaskItem).id,
              'count': element.count,
            })
      );

      if (elemResponse.statusCode == 200) {
        print('Created step');
      } else {
        throw Exception('Failed to create step');
      }
    }

    print("Created task");
    return id;
  } else {
    throw Exception('Failed to create task');
  }
}

// ASSIGN

Future assignTask(AssignModel assignment) async {
  final response = await http.post(
    Uri.http(_baseAddress, '/task/${assignment.idTask}/assign'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'date': assignment.dueDate,
      'user': assignment.idStudent,
    })
  );

  if (response.statusCode == 200) {
    print('Task assigned');
  }
  else {
    throw Exception('Failed to assign task');
  }
}

// GET INFO

// FIXED tasks

Future getAllFixedTasks(TaskModel task) async {}

Future<TaskModel> getFixedTaskFromId(int id) async {
  final response = await http.get(
    Uri.http(_baseAddress, '/task/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(utf8.decode(response.bodyBytes));
    return TaskModel.fromJSON(json, 0);
  } else {
    throw Exception('Failed to load task');
  }
}

// MATERIAL petition tasks

Future<List<TaskItem>> getAvailableItems() async {
  final response = await http.get(
    Uri.http(_baseAddress, '/item'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    }
  );

  if (response.statusCode == 200) {
    List<dynamic> itemList = jsonDecode(utf8.decode(response.bodyBytes));
    return itemList.map((json) => TaskItem.fromJSON(json)).toList();
  }
  else {
    throw Exception('Failed to fetch item list');
  }
}

void main() async {
  await assignTask(AssignModel(
    idTask: 1,
    idStudent: 2,
    dueDate: 'Dom 10/12/2023 0900'
  ));
}