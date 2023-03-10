import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perfumei/page/extensions/image_provider_extension.dart';
import 'package:image/image.dart' as img;

class RemoveBackGround {
  ///Para chamar direto por uma classe
  static Future<Uint8List> processarImagem(ImageProvider imageProvider) async {
    Uint8List? bytes =
        await imageProvider.getBytes(format: ImageByteFormat.png);

    return await removeWhiteBackground(bytes);
  }

//Para tornar possivel criar uma thread
  static Future<Uint8List> removeWhiteBackground(Uint8List? bytes) async {
    try {
      if (bytes == null || bytes.isEmpty) {
        throw Exception('Parâmetro de byte está vazio');
      }

      final image = img.decodeImage(bytes);

      if (image == null) {
        throw Exception('Não foi possível fazer o decode da imagem');
      }

      final croppedImage =
          img.copyCrop(image, 0, 0, image.width ~/ 1.9, image.height);
      final transparentImage =
          await _makeColorTransparent(croppedImage, 245, 245, 245);
      return Uint8List.fromList(img.encodePng(transparentImage!));
    } catch (e) {
      // TODO: tratar exceção
    }
    return Future.value(bytes);
  }

  static Future<img.Image?> _makeColorTransparent(
      img.Image src, int red, int green, int blue) async {
    var bytes = src.getBytes();
    for (int i = 0, len = bytes.length; i < len; i += 4) {
      if (bytes[i] > red && bytes[i + 1] > green && bytes[i + 2] > blue) {
        bytes[i + 3] = 0;
      }
    }

    return img.Image.fromBytes(src.width, src.height, bytes);
  }
}
