import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfumei/common/features/html_decode_page.dart';
import 'package:perfumei/common/model/dados_perfume.dart';
import 'package:perfumei/config/services/dio/request_service.dart';
import 'package:perfumei/pages/item/state/perfume_state.dart';

class PerfumeCubit extends Cubit<PerfumeState> {
  PerfumeCubit() : super(PerfumeState());

  void carregarHtml(String link) async {
    final retorno = await RequestService.getHtml(url: link);

    //Cria uma Thread para evitar lag no app
    final DadosPerfume perfume =
        await compute(HtmlDecodePage.decode, retorno.data.toString());

    emit(state.copyWith(dadosPerfume: perfume));
  }
}
