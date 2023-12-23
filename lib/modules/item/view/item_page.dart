import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:perfumei/common/components/notification/notificacao_padrao.dart';
import 'package:perfumei/common/enum/notas_enum.dart';
import 'package:perfumei/common/model/grid_model.dart';
import 'package:perfumei/modules/item/mobx/item_mobx.dart';
import 'package:perfumei/modules/item/widget/item_nota.dart';
import 'package:perfumei/modules/item/widget/item_topo.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({required this.item, this.bytes, super.key});
  final GridModel item;
  final Uint8List? bytes;

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final ObservableItem _observableItem = ObservableItem();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      NotificacaoPadrao.carregando();
      _observableItem.carregarHtml(widget.item.link);
      _observableItem.carregarImagem(context, widget.bytes);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _observableItem.clear();
  }

  ButtonSegment<NotasEnum> _makeSegmentedButton(NotasEnum nota) {
    final ThemeData tema = Theme.of(context);
    return ButtonSegment<NotasEnum>(
      value: nota,
      label: Text(
        nota.nome,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: nota.posicao == _observableItem.tabSelecionada.first.posicao ? tema.colorScheme.onPrimary : tema.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final ThemeData tema = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: tema.colorScheme.primary,
          size: 30,
          shadows: [
            BoxShadow(
              color: tema.colorScheme.onPrimaryContainer,
              blurRadius: 20,
              spreadRadius: 10,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 25,
          left: MediaQuery.of(context).orientation == Orientation.portrait ? 0 : 30,
        ),
        child: SingleChildScrollView(
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
                  opacity: 1,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      bottom: 10,
                      right: 18,
                    ),
                    width: width,
                    child: SegmentedButton<NotasEnum>(
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
                      builder: (_) => ItemNota(lista: _observableItem.notasTopo),
                    ),
                    Observer(
                      builder: (_) => ItemNota(lista: _observableItem.notasCoracao),
                    ),
                    Observer(
                      builder: (_) => ItemNota(lista: _observableItem.notasBase),
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
