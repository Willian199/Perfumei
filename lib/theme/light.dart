import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:util/constantes/export.dart';

class LigthTheme {
  static final ThemeData _default = FlexThemeData.light(
    scheme: FlexScheme.blumineBlue,
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    blendLevel: 9,
    usedColors: 6,
    appBarElevation: Double.ZERO,
    transparentStatusBar: true,
    applyElevationOverlayColor: false,
    appBarOpacity: Double.UM,
    tabBarStyle: FlexTabBarStyle.forBackground,
    bottomAppBarElevation: Double.ZERO,
    //Para testar layout. Em produção não usar
    //platform: TargetPlatform.windows,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    subThemesData: FlexSubThemesData(
      outlinedButtonOutlineSchemeColor: SchemeColor.onPrimaryContainer,
      appBarBackgroundSchemeColor: SchemeColor.secondaryContainer,
      appBarCenterTitle: !Platform.isIOS,
      interactionEffects: true,
      buttonMinSize: const Size(Double.CEM, Double.QUARENTA),
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: Double.VINTE,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorBorderWidth: Double.UM,
      inputDecoratorFillColor: Colors.white70,
      inputDecoratorIsFilled: true,
      useTextTheme: true,
      thinBorderWidth: Double.DOIS,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      useKeyColors: true,
    ),
    tones: FlexTones.vividSurfaces(Brightness.light),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );

  static Color _getColorSegmentedButton(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return _default.colorScheme.secondary;
    }
    return _default.colorScheme.onPrimary;
  }

  static Color _getColorSegmentedButtonIcon(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return _default.colorScheme.onPrimary;
    }
    return _default.colorScheme.primary;
  }

  static ThemeData getTheme() {
    return _default.copyWith(
      appBarTheme: _default.appBarTheme.copyWith(
        scrolledUnderElevation: Double.ZERO,
        surfaceTintColor: Colors.transparent,
      ),
      segmentedButtonTheme: _default.segmentedButtonTheme.copyWith(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith(_getColorSegmentedButton),
          iconColor:
              MaterialStateProperty.resolveWith(_getColorSegmentedButtonIcon),
          animationDuration: const Duration(seconds: Integer.DEZ),
        ),
      ),
      splashColor: _default.colorScheme.secondary,
    );
  }
}
