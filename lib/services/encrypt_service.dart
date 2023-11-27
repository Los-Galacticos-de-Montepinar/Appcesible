import 'dart:io';
import 'dart:typed_data';

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
  Uint8List data = stringToUint8List(message);
  Uint8List dataEncrypted = rsaEncrypt(getServerPublicKey(), data);
  //print(dataEncrypted);
  String json = jsonEncode(<String, dynamic>{
    'data': dataEncrypted
  });
  print(json);
  print(dataEncrypted.length);

  //var request = http.MultipartRequest(
  //  'POST',
  //  Uri.http('localhost:8080', '/session/test')
  //);
  //request.files.add(http.MultipartFile.fromBytes('data', dataEncrypted));
  //request.send().then((response) {
  //  if (response.statusCode == 200) {
  //    print(response.stream);
  //  }
  //  else {
  //    throw Exception('Server cannot decrypt');
  //  }
  //});

  //final request = http.Request(
  //  'POST',
  //  Uri.http('localhost:8080', '/session/test')
  //);
  //request.headers.addAll(<String, String>{
  //  'Content-Type': 'application/json; charset=UTF-8'
  //});
  //request.body = jsonEncode(<String, dynamic>{
  //  'data': dataEncrypted
  //});

  //final streamedResponse = await request.send();
  //final response = await http.Response.fromStream(streamedResponse);

  final response = await http.post(
    Uri.http('localhost:8080', '/session/test'),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream'
    },
    body: dataEncrypted,
  );

  if (response.statusCode == 200) {
    print(response.body);
  }
  else {
    throw Exception('Server cannot decrypt');
  }
}

void main() async {
  getKeyFromServer();
  Future.delayed(const Duration(seconds: 5));
  //stdin.readLineSync();
  //print(getServerPublicKey().modulus);
  //sendEncryptedMessage('hola este es un mensaje encriptado');
}
