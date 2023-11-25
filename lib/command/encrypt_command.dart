import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';
import "package:pointycastle/export.dart";

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> _pair = _generateRSAkeyPair(_exampleSecureRandom());
String _publicPem = _encodePublicKeyToPemPKCS1(_pair.publicKey);

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateKeyPair() => _pair;
String generatePem() => _publicPem;

AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> _generateRSAkeyPair(SecureRandom secureRandom, {int bitLength = 2048}) {
  // Create an RSA key generator and initialize it

  // final keyGen = KeyGenerator('RSA'); // Get using registry
  final keyGen = RSAKeyGenerator();

  keyGen.init(ParametersWithRandom(
      RSAKeyGeneratorParameters(BigInt.parse('65537'), bitLength, 64),
      secureRandom));

  // Use the generator

  final pair = keyGen.generateKeyPair();

  // Cast the generated key pair into the RSA key types

  final myPublic = pair.publicKey as RSAPublicKey;
  final myPrivate = pair.privateKey as RSAPrivateKey;  

  return AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate);
}

SecureRandom _exampleSecureRandom() {

  final secureRandom = SecureRandom('Fortuna')
    ..seed(KeyParameter(
        Platform.instance.platformEntropySource().getBytes(32)));
  return secureRandom;
}

String _encodePublicKeyToPemPKCS1(RSAPublicKey publicKey) {
    var topLevel = ASN1Sequence();
    topLevel.add(ASN1Integer(publicKey.modulus));
    topLevel.add(ASN1Integer(publicKey.exponent));
    topLevel.encode();

    var dataBase64 = base64.encode(topLevel.encodedBytes as List<int>);
    return """-----BEGIN PUBLIC KEY-----\r\n$dataBase64\r\n-----END PUBLIC KEY-----""";
}

Uint8List rsaEncrypt(RSAPublicKey myPublic, Uint8List dataToEncrypt) {
  final encryptor = OAEPEncoding(RSAEngine())
    ..init(true, PublicKeyParameter<RSAPublicKey>(myPublic)); // true=encrypt

  return _processInBlocks(encryptor, dataToEncrypt);
}

Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText) {
  final decryptor = OAEPEncoding(RSAEngine())
    ..init(false, PrivateKeyParameter<RSAPrivateKey>(myPrivate)); // false=decrypt

  return _processInBlocks(decryptor, cipherText);
}

Uint8List _processInBlocks(AsymmetricBlockCipher engine, Uint8List input) {
  final numBlocks = input.length ~/ engine.inputBlockSize +
      ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

  final output = Uint8List(numBlocks * engine.outputBlockSize);

  var inputOffset = 0;
  var outputOffset = 0;
  while (inputOffset < input.length) {
    final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
        ? engine.inputBlockSize
        : input.length - inputOffset;

    outputOffset += engine.processBlock(
        input, inputOffset, chunkSize, output, outputOffset);

    inputOffset += chunkSize;
  }

  return (output.length == outputOffset)
      ? output
      : output.sublist(0, outputOffset);
}

Uint8List stringToUint8List(String str) {
  final List<int> codeUnits = str.codeUnits;
  final Uint8List uint8list = Uint8List.fromList(codeUnits);

  return uint8list;
}

String uint8ListToString(Uint8List uint8list) {
  return String.fromCharCodes(uint8list);
}

void main() {
}
