import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfumei/model/GridModel.dart';
import 'package:perfumei/page/componentes/cache_image.dart';
import 'package:util/componentes/Degrade.dart';
import 'package:util/constantes/export.dart';

class GridRow extends StatelessWidget {
  final GridModel grid;
  final IconData? icon;
  final Function onPressed;

  const GridRow({
    super.key,
    required this.grid,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);

    final baseTextStyle =
        TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily);

    final itemsTextStyle = baseTextStyle.copyWith(
        color: tema.colorScheme.onPrimary,
        fontSize: Double.DOZE,
        fontWeight: FontWeight.w400);

    final subTituloTextStyle = itemsTextStyle.copyWith(fontSize: Double.DOZE);

    final tituloTextStyle = baseTextStyle.copyWith(
      color: tema.colorScheme.onPrimary,
      fontSize: Double.DEZESSEIS,
      fontWeight: FontWeight.w600,
    );

    Widget _gridValue({required String value, required IconData icon}) {
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
      margin: const EdgeInsets.fromLTRB(
          87.0, Double.DOZE, Double.CINCO, Double.CINCO),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: Double.QUATRO),
            FittedBox(
              child: Text(
                grid.nome,
                style: tituloTextStyle,
              ),
            ),
            Container(height: Double.DEZ),
            Text(
              grid.marca,
              style: subTituloTextStyle,
            ),
            Container(
              decoration: Degrade.efeitoDegrade(
                cores: [
                  const Color(0xff00F6ff),
                  const Color(0xFF436AB7),
                  tema.colorScheme.secondary
                ],
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
              ),
              margin: const EdgeInsets.symmetric(vertical: Double.SEIS),
              height: Double.DOIS,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _gridValue(
                      value: 'Gênero: ${grid.genero}', icon: Icons.directions),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: tema.colorScheme.onPrimary,
                      size: Double.DOZE,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Double.CINCO),
                      child: Text(
                        grid.avaliacao,
                        style: TextStyle(
                          color: tema.colorScheme.onPrimary,
                          fontSize: Double.DOZE,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: _gridValue(
                  value: 'Ano de Lançamento: ${grid.anoLancamento}',
                  icon: Icons.info),
            ),
          ]),
    );

    final gridCard = Padding(
      padding: const EdgeInsets.only(right: Double.QUINZE),
      child: Container(
        height: 135.0,
        margin: const EdgeInsets.only(left: 50.0),
        decoration: BoxDecoration(
          color: tema.colorScheme.secondary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Double.VINTE),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: Double.DEZ,
              offset: Offset(Double.DEZ, Double.DEZ),
            ),
          ],
        ),
        child: MaterialButton(
          highlightElevation: Double.TRES,
          animationDuration: const Duration(seconds: Integer.DEZ),
          onPressed: () => onPressed(grid),
          child: gridCardConteudo,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        gridCard,
        Positioned(
          top: Double.ZERO,
          left: Double.ZERO,
          child: CacheImagem(
            imagemUrl: grid.capa,
            imagemBuilder: (context, imageProvider) {
              return Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: imageProvider,
                  radius: Double.SESSENTA,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
