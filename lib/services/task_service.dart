import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/task_model.dart';

String baseAddress = '10.0.2.2:8080';

// FIXED tasks

void createTask(TaskModel task) async {
  final taskResponse = await http.post(
    Uri.http(baseAddress, (task.type == 0) ? '/task/new' : '/task/petition/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'title': task.title,
      'desc': task.description
    }),
  );

  if (taskResponse.statusCode == 200) {
    print("Created task");

    int id = 0;

    for (TaskElement element in task.elements) {
      final elemResponse = await http.post(
        Uri.http(baseAddress, (task.type == 0) ? 'task/step/new' : 'task/petition/$id/item/new'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: (task.type == 0) ?
          jsonEncode(<String, dynamic>{
          'taskId': id,
          'description': (element as Step).description,
          'media': element.media,
          'order': element.stepNumber
        })
        : jsonEncode(<String, dynamic>{
          'taskId': id,
          'item': (element as TaskItem).id,
          'count': element.quantity
        })
      );

      if (elemResponse.statusCode == 200) {
        print('Created step');
      }
      else {
        throw Exception('Failed to create step');
      }
    }
  }
  else {
    throw Exception('Failed to create task');
  }
}

void getAllFixedTasks(TaskModel task) async {

}

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

void createPetitionTask(TaskModel task) {

}

void main() {
  TaskModel task = TaskModel(id: 1, type: 0, description: 'desc', title: 'title', idPicto: 8);
  task.addElement(Step(description: 'description1', media: 'media1', stepNumber: 1));
  task.addElement(Step(description: 'description2', media: 'media2', stepNumber: 2));
  task.addElement(Step(description: 'description3', media: 'media3', stepNumber: 3));
  task.addElement(Step(description: 'description4', media: 'media4', stepNumber: 4));
  task.addElement(Step(description: 'description5', media: 'media5', stepNumber: 5));

  for (TaskElement element in task.elements) {
    print(jsonEncode(<String, String>{
      'taskId': '${task.id}',
      'description': (element as Step).description,
      'media': element.media,
      'order': '${element.stepNumber}'
    }));
    print('\n');
  }
}
