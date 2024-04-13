import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddi/flutter_ddi.dart';
import 'package:perfumei/common/enum/notas_enum.dart';
import 'package:perfumei/pages/item/state/tab_state.dart';

class TabCubit extends Cubit<TabState> with PostConstruct {
  TabCubit()
      : super(
          TabState(
            page: NotasEnum.TOPO.posicao,
            tabSelecionada: {NotasEnum.TOPO},
          ),
        );

  void changeTabSelecionada(Set<NotasEnum> value) {
    emit(state.copyWith(page: value.first.posicao, tabSelecionada: value));
  }

  @override
  void onPostConstruct() {
    ddiStream.subscribe<int>(
      qualifier: 'page_view',
      callback: (int newPAge) {
        debugPrint('pageChange');
        final NotasEnum? notaEnum = NotasEnum.forIndex(newPAge);

        if (notaEnum != null) {
          emit(state.copyWith(page: newPAge, tabSelecionada: {notaEnum}));
        }
      },
    );
  }

  @override
  Future<void> close() async {
    debugPrint('Destruindo a stream page_view');
    ddiStream.close(qualifier: 'page_view');
    super.close();
  }
}
