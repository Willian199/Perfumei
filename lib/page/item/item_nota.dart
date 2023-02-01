import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfumei/page/componentes/cache_image.dart';
import 'package:util/constantes/Double.dart';

class ItemNota extends StatelessWidget {
  final Map<String, String>? lista;
  const ItemNota({required this.lista, super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Double.DEZ),
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: lista?.values.length ?? 0,
            padding: const EdgeInsets.symmetric(horizontal: Double.DEZ),
            itemBuilder: (BuildContext context, int index) {
              final String? key = lista?.keys.elementAt(index);

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Double.VINTE,
                    ),
                    child: CacheImagem(
                      height: 100,
                      width: 130,
                      errorIcon: FontAwesomeIcons.sprayCanSparkles,
                      imagemUrl: lista?[key] ?? '',
                      imagemBuilder: (context, imageProvider) {
                        return Container(
                          height: 120,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: tema.colorScheme.onPrimaryContainer,
                                  offset: const Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: tema.colorScheme.primaryContainer,
                                  offset: const Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: Double.SESSENTA,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: Center(
                      child: Text(
                        key ?? '',
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
