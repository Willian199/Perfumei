import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:perfumei/page/extensions/image_provider_extension.dart';
import 'package:image/image.dart' as img;

class RemoveBackGround {
  ///Para chamar direto por uma classe
  static Future<Uint8List> processarImagem(
      BuildContext context, ImageProvider imageProvider) async {
    Uint8List? bytes =
        await imageProvider.getBytes(context, format: ImageByteFormat.png);

    return await removeWhiteBackground(bytes);
  }

  static img.Image _decodeImageBytes(Uint8List originalImageBytes) {
    late final img.Image? image;

    final decoder = img.findDecoderForData(originalImageBytes);

    if (decoder == null) {
      throw Exception('Imagem não suportada');
    }

    image = decoder.decodeImage(originalImageBytes);

    if (image == null) {
      throw Exception('Não foi possivel fazero de code da imagem');
    }

    return image;
  }

  static Uint8List _encodeImage(img.Image newImage) {
    return Uint8List.fromList(img.encodePng(newImage));
  }

//Para tornar possivel criar uma thread
  static Future<Uint8List> removeWhiteBackground(Uint8List? bytes) async {
    try {
      if (bytes != null && bytes.isNotEmpty) {
        img.Image? image = img.decodeImage(bytes);

        if (image == null) {
          throw Exception('Não foi possivel fazer o decode da imagem');
        }
        image = img.copyCrop(image, 0, 0, image.width ~/ 1.9, image.height);

        img.Image? transparentImage =
            await _colorTransparent(image, 245, 245, 245);

        //Verificar necessidade dessa parte
        var newPng = img.encodePng(transparentImage!);

        Uint8List unit8list = Uint8List.fromList(newPng);

        return _encodeImage(_decodeImageBytes(unit8list));
      } else {
        throw Exception('Parâmetro de byte está vazio');
      }
    } catch (e) {
      //TODO
    }
    return Future.value(bytes);
  }

  static Future<img.Image?> _colorTransparent(
      img.Image src, int red, int green, int blue) async {
    var bytes = src.getBytes();
    for (int i = 0, len = bytes.length; i < len; i += 4) {
      if ((bytes[i] > red && bytes[i + 1] > green && bytes[i + 2] > blue)) {
        bytes[i + 3] = 0;
      }
    }

    return img.Image.fromBytes(src.width, src.height, bytes);
  }
}
