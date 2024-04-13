import 'package:flutter/material.dart';
import 'package:flutter_ddi/flutter_ddi.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:perfumei/config/theme/dark.dart';
import 'package:perfumei/config/theme/light.dart';
import 'package:perfumei/pages/home/module/home_module.dart';
import 'package:perfumei/pages/home/view/home_page.dart';

void main() async {
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  //ddi.setDebugMode(false);

  //unawaited(WakelockPlus.enable());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterDDIFutureWidget(
      module: HomeModule.new,
      child: (_) => MaterialApp(
        title: 'Perfumei',
        navigatorKey: ddi(),
        debugShowCheckedModeBanner: false,
        //Git Request to make it default
        theme: LigthTheme.getTheme(),
        darkTheme: DarkTheme.getTheme(),
        // If you do not have a themeMode switch, uncomment this line
        // to let the device system mode control the theme mode:
        //themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
