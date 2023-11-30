import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/task_model.dart';

String baseAddress = '10.0.2.2:8080';

void createTask(TaskModel task) async {
  final taskResponse = await http.post(
    Uri.http(
        baseAddress, (task.type == 0) ? '/task/new' : '/task/petition/new'),
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
              baseAddress,
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

    print("Created task");
  } else {
    throw Exception('Failed to create task');
  }
}

// FIXED tasks

void getAllFixedTasks(TaskModel task) async {}

Future<TaskModel> getFixedTaskFromId(int id) async {
  final response = await http.get(Uri.http(baseAddress, '/task/$id'),
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

// MATERIAL petition tasks

void main() async {
  final taskResponse = await http.post(
    Uri.http(baseAddress, '/task/new'),
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
