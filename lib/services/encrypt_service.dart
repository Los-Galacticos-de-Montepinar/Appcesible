import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/command/encrypt_command.dart';

String _baseAddress = '10.0.2.2:8080';

void getKeyFromServer() async {
  final response = await http.get(
    Uri.http(_baseAddress, '/session/public'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  print('esperando respuesta');

  if (response.statusCode == 200) {
    //Map<String, dynamic> json = jsonDecode(response.body);
    String data = response.body;

    print(data);
  }
}

void sendPublicKey() async {
  final response = await http.post(
    Uri.http(_baseAddress, '/session/test'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'data': generatePem()
    }),
  );
}

void main() {
  getKeyFromServer();
}
