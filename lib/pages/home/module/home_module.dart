import 'dart:async';
import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_objectbox_store/dio_cache_interceptor_objectbox_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ddi/flutter_ddi.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:perfumei/common/constants/injection_constants.dart';
import 'package:perfumei/pages/home/cubit/home_cubit.dart';

class HomeModule with DDIModule {
  @override
  Future<void> onPostConstruct() async {
    Future.wait([
      ddi.registerObject<String>('https://fgvi612dfz-dsn.algolia.net', qualifier: InjectionConstants.url),
      ddi.registerSingleton<GlobalKey<NavigatorState>>(() => GlobalKey<NavigatorState>()),
      ddi.registerObject<bool>(WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark,
          qualifier: InjectionConstants.darkMode),
      ddi.registerDependent<HomeCubit>(HomeCubit.new),
    ]);

    await ddi.registerSingleton<CacheStore>(() async {
      final Directory dir = await pp.getTemporaryDirectory();
      return ObjectBoxCacheStore(storePath: dir.path);
    });
  }
}
