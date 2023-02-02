import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:perfumei/page/item/item_mobx.dart';
import 'package:util/constantes/Double.dart';

class Descricao extends StatelessWidget {
  final ObservableItem controller;
  const Descricao({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.descricao.isEmpty) {
        return const SizedBox();
      }
      return AnimatedOpacity(
        opacity: Double.UM,
        duration: const Duration(milliseconds: 500),
        child: Text(
          controller.descricao,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.primary,
            fontSize: Double.QUATORZE,
            height: 1.8,
          ),
        ),
      );
    });
  }
}
