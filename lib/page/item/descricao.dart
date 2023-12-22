import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:perfumei/page/item/item_mobx.dart';

class Descricao extends StatelessWidget {
  const Descricao({required this.controller, super.key});
  final ObservableItem controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.descricao.isEmpty) {
        return const SizedBox();
      }
      return AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 500),
        child: Text(
          controller.descricao,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            height: 1.8,
          ),
        ),
      );
    });
  }
}
