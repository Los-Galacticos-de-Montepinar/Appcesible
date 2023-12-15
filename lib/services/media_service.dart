import 'package:appcesible/models/gallery_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

// String _baseAddress = '10.0.2.2:8080';      // IP emulador
// String _baseAddress = 'localhost:8080';
String _baseAddress = '100.70.70.131:8080';  // IP privada
// String _baseAddress = '100.99.220.41:8080';  // IP ordenador

Future<int> uploadImage(File img) async {
  print(img.readAsBytesSync());
  
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
  request.headers.addAll(<String, String> {
    'Content-Type': 'multipart/form-data'
  });

  print(request.headers);
  
  final streamedResponse = await request.send();
  final response = await streamedResponse.stream.bytesToString();

  if (streamedResponse.statusCode == 200) {
    print('Image uploaded!');
    return int.parse(utf8.decode(response.codeUnits));
  }
  else {
    throw Exception('Failed to upload image. Status code ${streamedResponse.statusCode}');
  }
}

Future<Image> downloadImage(int id) async {
  final response = await http.get(
    Uri.http(_baseAddress, '/gallery/$id'),
    headers: <String, String> {
      'Content-Type': 'application/octet-stream'
    },
  );

  if (response.statusCode == 200) {
    return Image.memory(response.bodyBytes);
  }
  else {
    throw Exception('Failed to fetch image');
  }
}

Future<List<GalleryModel>> getGallery() async {
  final response = await http.get(
    Uri.http(_baseAddress, '/gallery'),
    headers:  <String, String> {
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> galleryList = jsonDecode(utf8.decode(response.bodyBytes));
    return galleryList.map((json) => GalleryModel.fromJSON(json)).toList();
  }
  else {
    throw Exception('Failed to fetch gallery');
  }
}
