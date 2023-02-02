import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:perfumei/page/componentes/slide_animation.dart';
import 'package:perfumei/page/item/item_mobx.dart';
import 'package:util/constantes/Double.dart';

class ImagemPerfume extends StatelessWidget {
  final ObservableItem controller;
  const ImagemPerfume({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.imagem?.isNotEmpty ?? false) {
        return Positioned(
          right: Double.ZERO,
          top: Double.TRINTA,
          child: SizedBox(
            width: 190,
            child: SlideAnimation(
              child: Image.memory(
                controller.imagem!,
              ),
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
