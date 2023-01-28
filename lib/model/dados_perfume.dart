class DadosPerfume {
  int id;
  String descricao;
  List<String?>? notasTopo;
  List<String?>? notasCoracao;
  List<String?>? notasBase;
  List<String?>? acordes;

  DadosPerfume({
    required this.id,
    required this.descricao,
    required this.notasTopo,
    required this.notasCoracao,
    required this.notasBase,
    required this.acordes,
  });
}
