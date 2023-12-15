import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:path/path.dart';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = 'localhost:8080';
String _baseAddress = '100.70.70.131:8080';  // IP privada
// String _baseAddress = '100.99.220.41:8080';  // IP ordenador

Future uploadImage(File img) async {
  List<String> mimeType = lookupMimeType(img.path)!.split('/');
  List<String> imgPath = split(img.path);
  String imgName = imgPath[imgPath.length-1];

  Uint8List bytes = await img.readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'filedata', 
    bytes, 
    filename: imgName,
    contentType: MediaType(mimeType[0], mimeType[1])
    );

  var request = http.MultipartRequest(
    'POST',
    Uri.http(_baseAddress, '/gallery/new'),
  );
  request.files.add(multipartFile);
  request.headers.putIfAbsent('Content-Type', () => 'multipart/form-data');

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


