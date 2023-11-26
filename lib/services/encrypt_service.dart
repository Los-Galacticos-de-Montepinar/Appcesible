import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:appcesible/command/encrypt_command.dart';

String _baseAddress = '10.0.2.2:8080';

// KEYS managemet methods

void getKeyFromServer() async {
  final response = await http.get(
    Uri.http('localhost:8080', '/session/public'),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream'
    },
  );

  if (response.statusCode == 200) {
    //Map<String, dynamic> json = jsonDecode(response.body);
    //print(response.bodyBytes);
    setServerPublicKey(response.bodyBytes, true);
    sendEncryptedMessage('hola este es un mensaje encriptado');
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

// ENCRYPT methods

void sendEncryptedMessage(String message) async {
  final response = await http.post(
    Uri.http('localhost:8080', '/session/test'),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream'
    },
    body: rsaEncrypt(getServerPublicKey(), stringToUint8List(message)),
  );

  if (response.statusCode == 200) {
    print(response.body);
  }
  else {
    throw Exception('Server cannot decrypt');
  }
}

void main() {
  getKeyFromServer();
  //stdin.readLineSync();
  //print(getServerPublicKey().modulus);
  //sendEncryptedMessage('hola este es un mensaje encriptado');
}
