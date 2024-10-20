import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddi/flutter_ddi.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:perfumei/common/components/fields/alpha_numeric_field.dart';
import 'package:perfumei/common/components/widgets/degrade.dart';
import 'package:perfumei/common/enum/genero_enum.dart';
import 'package:perfumei/common/extensions/image_provider_extension.dart';
import 'package:perfumei/common/model/grid_model.dart';
import 'package:perfumei/pages/home/cubit/home_cubit.dart';
import 'package:perfumei/pages/home/state/home_state.dart';
import 'package:perfumei/pages/home/widgets/grid_page.dart';
import 'package:perfumei/pages/item/module/item_module.dart';
import 'package:perfumei/pages/item/view/item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, DDIInject<HomeCubit> {
  late AnimationController _animationController;

  TextEditingController pesquisaController = TextEditingController();
  FocusNode pesquisaFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    Future.delayed(Duration.zero, () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
          child: BlocProvider<HomeCubit>(
            create: (_) => instance,
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
                          controller: pesquisaController,
                          focus: pesquisaFocus,
                          cursorColor: tema.colorScheme.primary,
                          textStyle: TextStyle(color: tema.colorScheme.primary),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            hintText: 'Pesquisa...',
                          ),
                          onChanged: instance.changePesquisa,
                          onFinish: () {
                            pesquisaFocus.unfocus();
                            instance.carregarDados();
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
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) => previous.tabSelecionada != current.tabSelecionada,
                  builder: (_, HomeState state) {
                    return Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 18),
                      width: MediaQuery.sizeOf(context).width,
                      child: SegmentedButton<Genero>(
                        segments: <ButtonSegment<Genero>>[
                          _makeSegmentedButton(Genero.TODOS),
                          _makeSegmentedButton(Genero.MASCULINO),
                          _makeSegmentedButton(Genero.FEMININO),
                          _makeSegmentedButton(Genero.UNISEX),
                        ],
                        selected: state.tabSelecionada,
                        onSelectionChanged: (value) {
                          pesquisaFocus.unfocus();
                          instance.changeTabSelecionada(value);
                          instance.carregarDados();
                        },
                        showSelectedIcon: false,
                      ),
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) => previous.dataChange != current.dataChange,
                    builder: (_, HomeState state) {
                      if (instance.dados?.isEmpty ?? true) {
                        return Center(
                          child: Lottie.asset(
                            "assets/desert.json",
                            fit: BoxFit.fitWidth,
                            repeat: true,
                            frameRate: FrameRate.max,
                          ),
                        );
                      }

                      return GridPage(
                        dados: instance.dados!,
                        onPressed: _abrirItem,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _abrirItem(GridModel itemSelecionado) {
    final ImageProvider provider = CachedNetworkImageProvider(itemSelecionado.capa);

    provider.getBytes(format: ImageByteFormat.png).then((bytes) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return FlutterDDIBuilder(
              module: ItemModule.new,
              child: (_) => ItemPage(
                item: itemSelecionado,
                bytes: bytes,
              ),
            );
          },
        ),
      );
    });
  }
}
