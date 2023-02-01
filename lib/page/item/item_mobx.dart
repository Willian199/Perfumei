import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:perfumei/page/enum/NotasEnum.dart';
import 'package:perfumei/page/util/processo/html_decode_page.dart';
import 'package:perfumei/page/util/processo/remove_background.dart';
import 'package:util/componentes/Notificacao.dart';

import 'package:util/services/RequestService.dart';

import '../../model/dados_perfume.dart';

part 'item_mobx.g.dart';

class ObservableItem = _ObservableItemBase with _$ObservableItem;

abstract class _ObservableItemBase with Store {
  final PageController pageController = PageController(
    initialPage: NotasEnum.TOPO.posicao,
  );

  @observable
  Uint8List? imagem;

  @observable
  String descricao = '';

  @observable
  Set<NotasEnum> tabSelecionada = {NotasEnum.TOPO};

  @observable
  int page = NotasEnum.TOPO.posicao;

  @observable
  List<String?>? acordes;

  @observable
  Map<String, String>? notasTopo;

  @observable
  Map<String, String>? notasCoracao;

  @observable
  Map<String, String>? notasBase;

  @action
  changeImagem(value) {
    imagem = value;
  }

  @action
  pageChange(int value) {
    NotasEnum? obj = NotasEnum.forIndex(value);

    if (obj != null) {
      tabSelecionada = {obj};
      page = value;
    }
  }

  @action
  changeTabSelecionada(Set<NotasEnum> value) {
    tabSelecionada = value;
    page = value.first.posicao;
    _navigate();
  }

  void _navigate() {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void clear() {
    descricao = '';
    acordes = null;
    notasTopo = null;
    notasCoracao = null;
    notasBase = null;
    imagem = null;
    page = 0;
    tabSelecionada = {NotasEnum.TOPO};
  }

  void carregarHtml(BuildContext context, String link) async {
    RequestService request = RequestService();

    var retorno = await request.getHtml(context: context, url: link);

    //Cria uma Thread para evitar lag no app
    DadosPerfume perfume =
        await compute(HtmlDecodePage.decode, retorno.data.toString());

    descricao = perfume.descricao;

    acordes = perfume.acordes;

    notasTopo = perfume.notasTopo;

    notasCoracao = perfume.notasCoracao;

    notasBase = perfume.notasBase;
  }

  void carregarImagem(BuildContext context, Uint8List? bytes) async {
    imagem = await compute(RemoveBackGround.removeWhiteBackground, bytes);

    Notificacao.close(context);
  }
}
