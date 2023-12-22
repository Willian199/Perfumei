import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfumei/model/grid_model.dart';
import 'package:perfumei/page/componentes/cache_image.dart';
import 'package:perfumei/page/util/components/Degrade.dart';

class GridRow extends StatelessWidget {
  const GridRow({
    required this.grid,
    required this.onPressed,
    super.key,
    this.icon,
  });
  final GridModel grid;
  final IconData? icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = Theme.of(context);

    final baseTextStyle = TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily);

    final itemsTextStyle = baseTextStyle.copyWith(color: tema.colorScheme.onPrimary, fontSize: 12, fontWeight: FontWeight.w400);

    final subTituloTextStyle = itemsTextStyle.copyWith(fontSize: 12);

    final tituloTextStyle = baseTextStyle.copyWith(
      color: tema.colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    Widget gridValue({required String value, required IconData icon}) {
      return Row(
        children: <Widget>[
          Text(
            value,
            style: itemsTextStyle,
          ),
        ],
      );
    }

    final gridCardConteudo = Container(
      margin: const EdgeInsets.fromLTRB(87.0, 12, 5, 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(height: 4),
        FittedBox(
          child: Text(
            grid.nome,
            style: tituloTextStyle,
          ),
        ),
        Container(height: 10),
        Text(
          grid.marca,
          style: subTituloTextStyle,
        ),
        Container(
          decoration: Degrade.efeitoDegrade(
            cores: [const Color(0xff00F6ff), const Color(0xFF436AB7), tema.colorScheme.secondary],
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          height: 2,
        ),
        Row(
          children: [
            Expanded(
              child: gridValue(value: 'Gênero: ${grid.genero}', icon: Icons.directions),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: tema.colorScheme.onPrimary,
                  size: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    grid.avaliacao,
                    style: TextStyle(
                      color: tema.colorScheme.onPrimary,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Expanded(
          child: gridValue(value: 'Ano de Lançamento: ${grid.anoLancamento}', icon: Icons.info),
        ),
      ]),
    );

    final gridCard = Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        height: 135.0,
        margin: const EdgeInsets.only(left: 50.0),
        decoration: BoxDecoration(
          color: tema.colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(10, 10),
            ),
          ],
        ),
        child: MaterialButton(
          highlightElevation: 3,
          animationDuration: const Duration(seconds: 10),
          onPressed: () => onPressed(grid),
          child: gridCardConteudo,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gridCard,
        Positioned(
          top: 0,
          left: 0,
          child: CacheImagem(
            imagemUrl: grid.capa,
            imagemBuilder: (context, imageProvider) {
              return Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: imageProvider,
                  radius: 60,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
