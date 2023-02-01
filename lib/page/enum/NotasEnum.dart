enum NotasEnum {
  TOPO('TOPO', 0),
  CORACAO('CORAÇÃO', 1),
  BASE('BASE', 2);

  final String nome;
  final int posicao;
  const NotasEnum(this.nome, this.posicao);

  static final Map<String, NotasEnum> findByNome = Map.fromEntries(
      NotasEnum.values.map((value) => MapEntry(value.nome, value)));

  static final Map<int, NotasEnum> findByPosicao = Map.fromEntries(
      NotasEnum.values.map((value) => MapEntry(value.posicao, value)));

  static NotasEnum? forValue(String value) {
    return findByNome[value];
  }

  static NotasEnum? forIndex(int value) {
    return findByPosicao[value];
  }
}
