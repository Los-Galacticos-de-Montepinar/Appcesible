import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/task_model.dart';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = 'localhost:8080';
String _baseAddress = '192.168.1.42:8080'; // IP ordenador

void createTask(TaskModel task) async {
  final taskResponse = await http.post(
    Uri.http(
        _baseAddress, (task.type == 0) ? '/task/new' : '/task/petition/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(
        <String, dynamic>{'title': task.title, 'desc': task.description}),
  );

  if (taskResponse.statusCode == 200) {
    int id = int.parse(taskResponse.body);

    for (TaskElement element in task.elements) {
      final elemResponse = await http.post(
          Uri.http(
              _baseAddress,
              (task.type == 0)
                  ? 'task/step/new'
                  : 'task/petition/$id/item/new'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: (task.type == 0)
              ? jsonEncode(<String, dynamic>{
                  'taskId': id,
                  'description': (element as Step).description,
                  'media': element.media,
                  'order': element.stepNumber
                })
              : jsonEncode(<String, dynamic>{
                  'taskId': id,
                  'item': (element as TaskItem).id,
                  'count': element.quantity
                }));

      if (elemResponse.statusCode == 200) {
        print('Created step');
      } else {
        throw Exception('Failed to create step');
      }
    }

    print('Created task');
  } else {
    throw Exception('Failed to create task');
  }
}

// FIXED tasks

void getAllFixedTasks(TaskModel task) async {}

Future<TaskModel> getFixedTaskFromId(int id) async {
  final response = await http.get(Uri.http(_baseAddress, '/task/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    return TaskModel.fromJSON(json, 0);
  } else {
    throw Exception('Failed to load task');
  }
}

// get all tasks from db
Future<List<TaskModel>> getAllTasks() async {
  final response = await http.get(
    Uri.http(_baseAddress, '/task'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<TaskModel> tasks = jsonList
        .map((json) => TaskModel.fromJSON(json,
            0)) // Asegúrate de que TaskModel tenga un constructor fromJSON adecuado
        .toList();

    return tasks;
  } else {
    throw Exception('Failed to load tasks');
  }
}

// MATERIAL petition tasks

void main() async {
  final taskResponse = await http.post(
    Uri.http(_baseAddress, '/task/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{'title': 'prueba1', 'desc': 'prueba1'}),
  );

  if (taskResponse.statusCode == 200) {
    int id = int.parse(taskResponse.body);
    print('RES - ${taskResponse.body}');
    print('ID - $id');
  } else {
    print('ERROR');
  }
}
