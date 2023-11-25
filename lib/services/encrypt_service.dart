import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/command/encrypt_command.dart';

String _baseAddress = '10.0.2.2:8080';

void sendPublicKey() async {
  final response = await http.post(
    Uri.http(_baseAddress, '/session/public'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'data': generatePem()
    }),
  );
}
