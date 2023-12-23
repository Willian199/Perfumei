import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:perfumei/common/components/notification/notificacao.dart';
import 'package:perfumei/common/components/notification/notificacao_padrao.dart';
import 'package:perfumei/common/enum/genero_enum.dart';
import 'package:perfumei/config/services/dio/request_service.dart';

part 'home_mobx.g.dart';

class ObservableHome = _ObservableHomeBase with _$ObservableHome;

abstract class _ObservableHomeBase with Store {
  TextEditingController pesquisaController = TextEditingController();
  FocusNode pesquisaFocus = FocusNode();

  @observable
  String pesquisa = '';

  @observable
  Set<Genero> tabSelecionada = {Genero.TODOS};

  @observable
  List? dados;

  @action
  void changePesquisa(String value) {
    pesquisa = value;
  }

  @action
  void changeTabSelecionada(Set<Genero> value) {
    tabSelecionada = value;
    pesquisaFocus.unfocus();
  }

  void carregarDados(context) async {
    pesquisaFocus.unfocus();
    NotificacaoPadrao.carregando();

    const String attributesToRetrieve = '["naslov","dizajner","godina","url.PT","rating","spol"]';

    const String facets =
        '"spol","dizajner","godina","ingredients.PT","rating_rounded","nosevi","osobine.PT","designer_meta.country","designer_meta.category","designer_meta.parent_company","designer_meta.main_activity"]';

    final String filter = tabSelecionada.first.nome.isEmpty ? '' : 'facetFilters=%5B%5B%22spol%3A${tabSelecionada.first.nome}%22%5D%5D&';

    const String highlight = 'highlightPostTag=__/ais-highlight__&highlightPreTag=__ais-highlight__';

    const String hitsPerPage = 'hitsPerPage=80&maxValuesPerFacet=10';

    const String page = 'page=0&tagFilters=';

    String params = 'attributesToRetrieve=$attributesToRetrieve&facets=$facets&$filter';

    params += '$highlight&$hitsPerPage&$page';

    params += '&query=$pesquisa';

    final obj = {
      "requests": [
        {"indexName": "fragrantica_perfumes", "params": params}
      ]
    };

    const String applicationId = 'FGVI612DFZ';
    const String applicatinoKey =
        'N2NhNTAyOWYzYTI0NzkyMWEyMTg1MTQ2ZDM5OGM4NjkzMjQ1ZThkNWI4MzgwOWJkMjY5YWU1ZDkyYmJlMzE3YnZhbGlkVW50aWw9MTcwNDE1MDE1MA==';

    final retorno = await RequestService.post(
        url: '/1/indexes/*/queries?x-algolia-api-key=$applicatinoKey&x-algolia-application-id=$applicationId',
        data: obj,
        usarCache: true,
        callbackErro: () {
          dados = [];
        });

    dados = retorno.data['results'][0]['hits'] as List;

    Future.delayed(const Duration(seconds: 1), () {
      Notificacao.close();
      pesquisaFocus.unfocus();
    });
  }
}
