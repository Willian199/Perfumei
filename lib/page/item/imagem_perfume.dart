import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:perfumei/page/componentes/slide_animation.dart';
import 'package:perfumei/page/item/item_mobx.dart';

class ImagemPerfume extends StatelessWidget {
  const ImagemPerfume({required this.controller, super.key});
  final ObservableItem controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.imagem?.isNotEmpty ?? false) {
        return Positioned(
          right: 0,
          top: 30,
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
