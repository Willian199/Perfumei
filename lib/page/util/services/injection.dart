import 'dart:io';

import 'package:dart_ddi/dart_di.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_objectbox_store/dio_cache_interceptor_objectbox_store.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:perfumei/constants/injection_constants.dart';

final DDI ddi = DDI.instance;

class Injection {
  static Future<void> start() async {
    ddi.registerSingleton<String>(() => 'https://fgvi612dfz-dsn.algolia.net', qualifierName: InjectionConstants.url);

    final Directory dir = await pp.getTemporaryDirectory();
    ddi.registerSingleton<CacheStore>(() => ObjectBoxCacheStore(storePath: dir.path));
  }
}
