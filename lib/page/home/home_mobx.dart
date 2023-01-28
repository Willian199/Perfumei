import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:perfumei/page/enum/GeneroEnum.dart';
import 'package:util/componentes/Notificacao.dart';
import 'package:util/componentes/NotificacaoPadrao.dart';
import 'package:util/services/RequestService.dart';

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
  changePesquisa(value) {
    pesquisa = value;
  }

  @action
  changeTabSelecionada(value) {
    tabSelecionada = value;
    pesquisaFocus.unfocus();
  }

  void carregarDados(context) async {
    pesquisaFocus.unfocus();
    NotificacaoPadrao.carregando(context);
    RequestService request = RequestService();

    String attributesToRetrieve =
        '["naslov","dizajner","godina","url.PT","rating","spol"]';

    String facets =
        '"spol","dizajner","godina","ingredients.PT","rating_rounded","nosevi","osobine.PT","designer_meta.country","designer_meta.category","designer_meta.parent_company","designer_meta.main_activity"]';

    String filter = tabSelecionada.first.nome.isEmpty
        ? ''
        : 'facetFilters=%5B%5B%22spol%3A${tabSelecionada.first.nome}%22%5D%5D&';

    String highlight =
        'highlightPostTag=__/ais-highlight__&highlightPreTag=__ais-highlight__';

    String hitsPerPage = 'hitsPerPage=80&maxValuesPerFacet=10';

    String page = 'page=0&tagFilters=';

    String params =
        'attributesToRetrieve=$attributesToRetrieve&facets=$facets&$filter';

    params += '$highlight&$hitsPerPage&$page';

    params += '&query=$pesquisa';

    var obj = {
      "requests": [
        {"indexName": "fragrantica_perfumes", "params": params}
      ]
    };

    String applicationId = 'FGVI612DFZ';
    String applicatinoKey =
        'Y2Q4NmU4ZTM1ZGQwYzRmYTk1NGQ4Y2IxMGFkZDFiMTAyZDJjZWI1ZWYzOGQ4NDljYjIzODNhNGZjYTU3ZDUwN3ZhbGlkVW50aWw9MTY3NTY0MzgxMw==';

    var retorno = await request.post(
      url:
          '/1/indexes/*/queries?x-algolia-api-key=$applicatinoKey&x-algolia-application-id=$applicationId',
      context: context,
      data: obj,
      usarCache: true,
      callbackErro: (){
        dados = [];
      }
    );

    dados = retorno.data['results'][0]['hits'];

    Future.delayed(const Duration(seconds: 1), () {
      Notificacao.close(context);
      pesquisaFocus.unfocus();
    });
  }
}
