import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfumei/common/components/notification/notificacao_padrao.dart';
import 'package:perfumei/common/enum/notas_enum.dart';
import 'package:perfumei/common/model/dados_perfume.dart';
import 'package:perfumei/common/model/grid_model.dart';
import 'package:perfumei/common/model/layout.dart';
import 'package:perfumei/config/services/injection.dart';
import 'package:perfumei/modules/item/cubit/item_cubit.dart';
import 'package:perfumei/modules/item/cubit/perfume_cubit.dart';
import 'package:perfumei/modules/item/state/tab_state.dart';
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
  final TabCubit _itemCubit = ddi();
  final PerfumeCubit _perfumeCubit = ddi();

  final Layout layout = ddi.get<Layout>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      NotificacaoPadrao.carregando();
      _perfumeCubit.carregarHtml(widget.item.link);
    });
  }

  ButtonSegment<NotasEnum> _makeSegmentedButton(NotasEnum nota, Set<NotasEnum> tabSelecionada) {
    return ButtonSegment<NotasEnum>(
      value: nota,
      label: Text(
        nota.nome,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: nota.posicao == tabSelecionada.first.posicao ? layout.segmentedButtonSelected : layout.segmentedButtonDeselected,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('building ItemPage');

    final double width = MediaQuery.sizeOf(context).width;
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
          left: MediaQuery.orientationOf(context) == Orientation.portrait ? 0 : 30,
        ),
        child: SingleChildScrollView(
          child: BlocProvider<PerfumeCubit>(
            create: (_) => _perfumeCubit,
            child: Column(
              children: [
                ItemTopo(
                  item: widget.item,
                  bytes: widget.bytes,
                ),
                BlocBuilder<PerfumeCubit, DadosPerfume?>(
                  builder: (_, DadosPerfume? dadosPerfume) {
                    if (dadosPerfume?.notasBase.isEmpty ?? true) {
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
                        child: BlocProvider<TabCubit>(
                          create: (_) => _itemCubit,
                          child: BlocBuilder<TabCubit, TabState>(
                            buildWhen: (previous, current) => previous.tabSelecionada != current.tabSelecionada,
                            builder: (_, TabState state) {
                              return SegmentedButton<NotasEnum>(
                                segments: <ButtonSegment<NotasEnum>>[
                                  _makeSegmentedButton(NotasEnum.TOPO, state.tabSelecionada),
                                  _makeSegmentedButton(NotasEnum.CORACAO, state.tabSelecionada),
                                  _makeSegmentedButton(NotasEnum.BASE, state.tabSelecionada),
                                ],
                                selected: state.tabSelecionada,
                                onSelectionChanged: (value) {
                                  _itemCubit.changeTabSelecionada(value);
                                },
                                showSelectedIcon: false,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: width,
                    height: 210,
                    child: BlocBuilder<PerfumeCubit, DadosPerfume?>(
                      builder: (_, DadosPerfume? dadosPerfume) {
                        return PageView(
                          controller: _itemCubit.pageController,
                          onPageChanged: _itemCubit.pageChange,
                          children: [
                            ItemNota(lista: dadosPerfume?.notasTopo),
                            ItemNota(lista: dadosPerfume?.notasCoracao),
                            ItemNota(lista: dadosPerfume?.notasBase),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
