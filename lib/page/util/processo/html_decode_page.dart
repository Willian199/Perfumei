import 'dart:async';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import '../../../model/dados_perfume.dart';

class HtmlDecodePage {
  static FutureOr<DadosPerfume> decode(String html) {
    Document document = parse(html);

    //Não foi possivel pegar os valores dos gráficos
    /*var gosto = document
        .getElementById("main-content")
        ?.getElementsByClassName("grid-x grid-margin-x grid-margin-y")[3]
        .nodes[0];
    var estacao = document
        .getElementById("main-content")
        ?.getElementsByClassName("grid-x grid-margin-x grid-margin-y")[3]
        .nodes[1];
    var logevidade = document
        .getElementById("main-content")
        ?.getElementsByClassName("cell small-12")[23];
    var projecao = document
        .getElementById("main-content")
        ?.getElementsByClassName("cell small-12")[24];
    var genero = document
        .getElementById("main-content")
        ?.getElementsByClassName("cell small-12")[25];
    var preco = document
        .getElementById("main-content")
        ?.getElementsByClassName("cell small-12")[26];*/

    List<String?>? acordes = document
        .getElementById("main-content")
        ?.getElementsByClassName("cell small-6")[1]
        .nodes[2]
        .nodes
        .map((item) => item.text)
        .toList();

    var notasCoracao = document
        .getElementById("pyramid")
        ?.nodes
        .first
        .nodes
        .first
        .nodes[1]
        .nodes[4]
        .nodes
        .first
        .nodes
        .map((item) => item.text)
        .toList();

    var notasBase = document
        .getElementById("pyramid")
        ?.nodes
        .first
        .nodes
        .first
        .nodes[1]
        .nodes[6]
        .nodes
        .first
        .nodes
        .map((item) => item.text)
        .toList();

    return DadosPerfume(
      id: 1,
      descricao: _processarDescricao(document),
      acordes: acordes!,
      notasTopo: _processarNotasTopo(document),
      notasCoracao: notasCoracao,
      notasBase: notasBase,
    );
  }

  static String _processarDescricao(Document document) {
    String? descricao = document
        .getElementById("main-content")
        ?.getElementsByClassName("reviewstrigger")
        .first
        .parent
        ?.firstChild
        ?.text;

    if (descricao?.isEmpty ?? true) {
      return "O Perfume não possui uma descrição";
    } else {
      //Para remover redundância de informações na descrição
      if (descricao?.contains("As notas de topo são:") ?? false) {
        return descricao?.split("As notas de topo são:").first ?? '';
      }

      return descricao?.split("A nota de topo é").first ?? '';
    }
  }

  static List<String?>? _processarNotasTopo(Document document) {
    return document
        .getElementById("pyramid")
        ?.nodes
        .first
        .nodes
        .first
        .nodes[1]
        .nodes
        .last
        .nodes
        .first
        .nodes
        .map((item) => item.text)
        .toList();
  }
}
