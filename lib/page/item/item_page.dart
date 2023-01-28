import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:perfumei/model/GridModel.dart';
import 'package:perfumei/page/item/item_mobx.dart';
import 'package:perfumei/page/item/item_topo.dart';
import 'package:util/componentes/NotificacaoPadrao.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        right: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ItemTopo(
                controller: _observableItem,
                item: widget.item,
              )
            ],
          ),
        ),
      ),
    );
  }
}
