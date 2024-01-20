import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfumei/common/features/html_decode_page.dart';
import 'package:perfumei/common/model/dados_perfume.dart';
import 'package:perfumei/config/services/dio/request_service.dart';

class PerfumeCubit extends Cubit<DadosPerfume?> {
  PerfumeCubit() : super(null);

  void carregarHtml(String link) async {
    final retorno = await RequestService.getHtml(url: link);

    //Cria uma Thread para evitar lag no app
    final DadosPerfume perfume = await compute(HtmlDecodePage.decode, retorno.data.toString());

    emit(perfume);
  }
}
