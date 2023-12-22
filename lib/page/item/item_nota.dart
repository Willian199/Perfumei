import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:perfumei/page/componentes/cache_image.dart';

class ItemNota extends StatelessWidget {
  const ItemNota({required this.lista, super.key});
  final Map<String, String>? lista;

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: lista?.values.length ?? 0,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (BuildContext context, int index) {
              final String? key = lista?.keys.elementAt(index);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
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
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50), boxShadow: [
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
                              radius: 60,
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
