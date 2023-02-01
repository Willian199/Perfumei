import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfumei/model/GridModel.dart';
import 'package:perfumei/page/componentes/cache_image.dart';
import 'package:perfumei/page/enum/NotasEnum.dart';
import 'package:perfumei/page/item/item_mobx.dart';
import 'package:perfumei/page/item/item_nota.dart';
import 'package:perfumei/page/item/item_topo.dart';
import 'package:util/componentes/ButtonNeomorphism.dart';
import 'package:util/componentes/NotificacaoPadrao.dart';
import 'package:util/constantes/Double.dart';

class ItemPage extends StatefulWidget {
  final GridModel item;
  final Uint8List? bytes;
  const ItemPage({required this.item, this.bytes, super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ObservableItem _observableItem = ObservableItem();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      NotificacaoPadrao.carregando(context);
      _observableItem.carregarHtml(context, widget.item.link);
      _observableItem.carregarImagem(context, widget.bytes);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _observableItem.clear();
  }

  Widget _buildTitulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Double.QUINZE),
      child: Text(
        titulo,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: Double.VINTE_CINCO),
      ),
    );
  }

  ButtonSegment<NotasEnum> _makeSegmentedButton(NotasEnum nota) {
    ThemeData tema = Theme.of(context);
    return ButtonSegment<NotasEnum>(
      value: nota,
      label: Text(
        nota.nome,
        style: TextStyle(
          fontSize: Double.DEZESSEIS,
          fontWeight: FontWeight.bold,
          color: nota.posicao == _observableItem.tabSelecionada.first.posicao
              ? tema.colorScheme.onPrimary
              : tema.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    ThemeData tema = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: tema.colorScheme.primary,
          size: Double.TRINTA,
          shadows: [
            BoxShadow(
              color: tema.colorScheme.onPrimaryContainer,
              offset: const Offset(0, 0),
              blurRadius: 20,
              spreadRadius: 10,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: Double.VINTE_CINCO,
          left: MediaQuery.of(context).orientation == Orientation.portrait
              ? Double.ZERO
              : Double.TRINTA,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ItemTopo(
                controller: _observableItem,
                item: widget.item,
              ),
              Observer(builder: (_) {
                if (_observableItem.notasBase?.isEmpty ?? true) {
                  return const SizedBox();
                }
                return AnimatedOpacity(
                  opacity: Double.UM,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: Double.DEZ,
                      left: Double.DEZ,
                      bottom: Double.DEZ,
                      right: Double.DEZOITO,
                    ),
                    width: width,
                    child: SegmentedButton<NotasEnum>(
                      emptySelectionAllowed: false,
                      segments: <ButtonSegment<NotasEnum>>[
                        _makeSegmentedButton(NotasEnum.TOPO),
                        _makeSegmentedButton(NotasEnum.CORACAO),
                        _makeSegmentedButton(NotasEnum.BASE),
                      ],
                      selected: _observableItem.tabSelecionada,
                      onSelectionChanged: (value) {
                        _observableItem.changeTabSelecionada(value);
                      },
                      showSelectedIcon: false,
                    ),
                  ),
                );
              }),
              SizedBox(
                width: width,
                height: 200,
                child: PageView(
                  controller: _observableItem.pageController,
                  onPageChanged: _observableItem.pageChange,
                  children: [
                    Observer(
                      builder: (_) =>
                          ItemNota(lista: _observableItem.notasTopo),
                    ),
                    Observer(
                      builder: (_) =>
                          ItemNota(lista: _observableItem.notasCoracao),
                    ),
                    Observer(
                      builder: (_) =>
                          ItemNota(lista: _observableItem.notasBase),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
