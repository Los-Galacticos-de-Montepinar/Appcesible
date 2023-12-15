import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:crypton/crypton.dart';

String _baseAddress = '100.99.220.41:8080';

void test(String pem,RSAPrivateKey privateKey) async {
  final response = await http.post(
    Uri.http(_baseAddress, '/session/public'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{
      'pem': pem
    }),
  );

  if (response.statusCode == 200) {
    print("Received message:");
    print(response.body);
    print("Decrypted:");
    print(privateKey.decrypt(response.body));
    
  } else {
    throw Exception('Failed to update User');
  }
}

void main() {
  print("START");
  RSAKeypair rsaKeypair = RSAKeypair.fromRandom(); 
  String pem = rsaKeypair.publicKey.toPEM();
  print(pem);
  test(pem,rsaKeypair.privateKey);
  print("SENDED");
}
