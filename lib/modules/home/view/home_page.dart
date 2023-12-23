import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:perfumei/common/components/fields/alpha_numeric_field.dart';
import 'package:perfumei/common/components/widgets/degrade.dart';
import 'package:perfumei/common/enum/genero_enum.dart';
import 'package:perfumei/common/extensions/image_provider_extension.dart';
import 'package:perfumei/common/model/grid_model.dart';
import 'package:perfumei/modules/home/mobx/home_mobx.dart';
import 'package:perfumei/modules/home/widgets/grid_page.dart';
import 'package:perfumei/modules/item/view/item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  final ObservableHome _controller = ObservableHome();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    Future.delayed(const Duration(milliseconds: 1), () {
      _controller.carregarDados(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  ButtonSegment<Genero> _makeSegmentedButton(Genero genero) {
    return ButtonSegment<Genero>(
      value: genero,
      icon: Icon(
        genero.icone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfumei',
          style: TextStyle(
            fontFamily: GoogleFonts.aladin().fontFamily,
            fontSize: 30,
          ),
        ),
      ),
      body: Container(
        decoration: Degrade.efeitoDegrade(cores: [
          tema.colorScheme.secondaryContainer,
          tema.colorScheme.tertiaryContainer,
        ]),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 18,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AlphaNumericField(
                        controller: _controller.pesquisaController,
                        focus: _controller.pesquisaFocus,
                        cursorColor: tema.colorScheme.primary,
                        textStyle: TextStyle(color: tema.colorScheme.primary),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          hintText: ' Pesquisa...',
                        ),
                        onChanged: _controller.changePesquisa,
                        onFinish: () {
                          _controller.carregarDados(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            _animationController.reset();
                            _animationController.forward();
                          },
                          child: Lottie.asset(
                            "assets/config.json",
                            fit: BoxFit.cover,
                            height: 50,
                            width: 55,
                            repeat: true,
                            controller: _animationController,
                            frameRate: FrameRate.max,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Observer(builder: (_) {
                return Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, right: 18),
                  width: MediaQuery.of(context).size.width,
                  child: SegmentedButton<Genero>(
                    segments: <ButtonSegment<Genero>>[
                      _makeSegmentedButton(Genero.TODOS),
                      _makeSegmentedButton(Genero.MASCULINO),
                      _makeSegmentedButton(Genero.FEMININO),
                      _makeSegmentedButton(Genero.UNISEX),
                    ],
                    selected: _controller.tabSelecionada,
                    onSelectionChanged: (value) {
                      _controller.changeTabSelecionada(value);
                      _controller.carregarDados(context);
                    },
                    showSelectedIcon: false,
                  ),
                );
              }),
              Expanded(
                child: Observer(builder: (_) {
                  if (_controller.dados == null) {
                    return const SizedBox();
                  } else if (_controller.dados?.isEmpty ?? false) {
                    return Center(
                      child: Lottie.asset(
                        "assets/desert.json",
                        fit: BoxFit.fitWidth,
                        repeat: true,
                        frameRate: FrameRate.max,
                      ),
                    );
                  } else {
                    return GridPage(
                      dados: _controller.dados!,
                      onPressed: _abrirItem,
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _abrirItem(GridModel itemSelecionado) async {
    final ImageProvider provider = CachedNetworkImageProvider(itemSelecionado.capa);

    provider.getBytes(format: ImageByteFormat.png).then((bytes) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return ItemPage(
          item: itemSelecionado,
          bytes: bytes,
        );
      }));
    });
  }
}
