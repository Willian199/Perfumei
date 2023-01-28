import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Genero {
  MASCULINO('male', FontAwesomeIcons.mars),
  FEMININO('female', FontAwesomeIcons.venus),
  UNISEX('unisex', FontAwesomeIcons.marsAndVenus),
  TODOS('', FontAwesomeIcons.peopleGroup);

  final String nome;
  final IconData icone;
  const Genero(this.nome, this.icone);

  static final Map<String, Genero> TYPES_BY_VALUE = Map.fromEntries(
      Genero.values.map((value) => MapEntry(value.nome, value)));

  static Genero? forValue(String value) {
    return TYPES_BY_VALUE[value];
  }
}
