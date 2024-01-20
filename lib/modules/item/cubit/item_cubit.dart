import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfumei/common/enum/notas_enum.dart';
import 'package:perfumei/modules/item/state/tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState(page: NotasEnum.TOPO.posicao, tabSelecionada: {NotasEnum.TOPO}));

  final PageController pageController = PageController(
    initialPage: NotasEnum.TOPO.posicao,
  );

  void pageChange(int value) {
    final NotasEnum? obj = NotasEnum.forIndex(value);

    if (obj != null) {
      emit(state.copyWith(page: value, tabSelecionada: {obj}));
    }
  }

  void changeTabSelecionada(Set<NotasEnum> value) {
    emit(state.copyWith(page: value.first.posicao, tabSelecionada: value));
    _navigate();
  }

  void _navigate() {
    pageController.animateToPage(state.page, duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
  }
}
