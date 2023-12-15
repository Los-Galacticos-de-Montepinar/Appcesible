import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = 'localhost:8080';
String _baseAddress = '192.168.1.42:8080';  // IP ordenador

Future uploadImage(File img) async {
  var bytes = await img.readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes('filedata', bytes, filename: 'test.png');

  var request = http.MultipartRequest(
    'POST',
    Uri.http(_baseAddress, '/gallery/new')
  );
  request.files.add(multipartFile);

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded!');
    }
    else {
      throw Exception('Failed to upload image. Status code ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to upload image: $e');
  }
}
