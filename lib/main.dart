import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfumei/page/home/home_page.dart';
import 'package:perfumei/theme/light.dart';
import 'package:util/services/DataControl.dart';
import 'package:wakelock/wakelock.dart';

late bool darkMode;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var data = DataControl();
  unawaited(Wakelock.enable());

  data.url = 'https://fgvi612dfz-dsn.algolia.net';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///Listener para remover o focus dos Textfield ao clicar fora do campo
    ///Péssimo comportamento ao tentar editar o valor de um textfield
    ///Listener(
    ///onPointerDown: (_) {
    /// FocusScopeNode currentFocus = FocusScope.of(context);
    ///  if (!currentFocus.hasPrimaryFocus) {
    ///    currentFocus.focusedChild?.unfocus();
    ///  }
    /// },
    ///  child: MaterialApp();

    return MaterialApp(
      title: 'Perfumei',
      debugShowCheckedModeBanner: false,
      //Git Request to make it default
      theme: LigthTheme.getTheme(),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blumineBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: const FlexSubThemesData(
          outlinedButtonOutlineSchemeColor: SchemeColor.onPrimaryContainer,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        tones: FlexTones.vividSurfaces(Brightness.dark),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      // If you do not have a themeMode switch, uncomment this line
      // to let the device system mode control the theme mode:
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}
