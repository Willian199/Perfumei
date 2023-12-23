import 'dart:async';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfumei/config/services/injection.dart';
import 'package:perfumei/config/theme/light.dart';
import 'package:perfumei/modules/home/view/home_page.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  unawaited(WakelockPlus.enable());

  Injection.start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfumei',
      navigatorKey: ddi(),
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
      //themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
