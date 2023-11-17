import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/models/task_model.dart';

String baseAddress = '10.0.2.2:8080';

void createTask(TaskModel task) async {
  final response = await http.post(
    Uri.http(baseAddress, '/task/new'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'title': task.title,
      'desc': task.description
    }),
  );

  if (response.statusCode == 200) {
    print("Created task");
  } else {
    throw Exception('Failed to create task');
  }
}

void getAllTasks(TaskModel task) async {

}

Future<TaskModel> getTaskFromId(int id) async {
  final response = await http.get(Uri.http(baseAddress, '/task/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    dynamic json = jsonDecode(response.body);
    return TaskModel.fromJSON(json);
  } else {
    throw Exception('Failed to load task');
  }
}
