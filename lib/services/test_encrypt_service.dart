import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypton/crypton.dart';

import 'package:appcesible/command/encrypt_command.dart';

String _baseAddress = 'localhost:8080';

void test() async {
  final response = await http.post(
    Uri.http(_baseAddress, '/session/public'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, dynamic>{'pem': Encrypt.publicKeyPem}),
  );

  if (response.statusCode == 200) {
    print('Received message:');
    print(response.body);
    print('Decrypted:');
    print(Encrypt.decrypt(response.body));
  } else {
    throw Exception('Failed to update User');
  }
}

void main() {
  print('START');
  RSAKeypair rsaKeypair = RSAKeypair.fromRandom();
  String pem = rsaKeypair.publicKey.toPEM();
  print(pem);
  test();
  print('SENDED');
}
