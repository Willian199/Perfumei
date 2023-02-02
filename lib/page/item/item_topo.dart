import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:perfumei/model/GridModel.dart';
import 'package:perfumei/page/componentes/slide_animation.dart';
import 'package:perfumei/page/item/descricao.dart';
import 'package:perfumei/page/item/imagem_perfume.dart';
import 'package:perfumei/page/item/item_mobx.dart';
import 'package:util/constantes/Double.dart';

class ItemTopo extends StatelessWidget {
  final ObservableItem controller;
  final GridModel item;
  const ItemTopo({required this.controller, required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = Theme.of(context);
    final double width = MediaQuery.of(context).size.width - 140;
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          ImagemPerfume(controller: controller),
          Positioned(
            left: Double.ZERO,
            top: Double.SESSENTA,
            child: Padding(
              padding: const EdgeInsets.only(
                left: Double.VINTE,
                top: Double.VINTE,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.marca,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tema.colorScheme.tertiary,
                      fontSize: Double.QUATORZE,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Double.DEZ,
                    ),
                    width: width,
                    child: Text(
                      item.nome,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: tema.colorScheme.primary,
                        fontSize: Double.VINTE_CINCO,
                      ),
                    ),
                  ),
                  Container(
                    width: Double.OITENTA,
                    height: Double.TRINTA,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: tema.colorScheme.primaryContainer,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: tema.colorScheme.primary,
                          size: Double.DOZE,
                        ),
                        Text(
                          item.avaliacao,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: tema.colorScheme.primary,
                            fontSize: Double.QUATORZE,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: Double.VINTE),
                    width: width - 80,
                    child: Descricao(
                      controller: controller,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
