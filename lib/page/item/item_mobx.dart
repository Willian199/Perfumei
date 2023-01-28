import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:perfumei/page/util/processo/html_decode_page.dart';
import 'package:perfumei/page/util/processo/remove_background.dart';
import 'package:util/componentes/Notificacao.dart';

import 'package:util/services/RequestService.dart';

import '../../model/dados_perfume.dart';

part 'item_mobx.g.dart';

class ObservableItem = _ObservableItemBase with _$ObservableItem;

abstract class _ObservableItemBase with Store {
  @observable
  Uint8List? imagem;

  @observable
  String descricao = '';

  @observable
  List<String?>? acordes;

  @observable
  List<String?>? notasTopo;

  @observable
  List<String?>? notasCoracao;

  @observable
  List<String?>? notasBase;

  @action
  changeImagem(value) {
    imagem = value;
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
