import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ddi/flutter_ddi.dart';

class CubitSender<State extends Object> extends Cubit<State> {
  CubitSender(super.initialState);

  void fire(State state) {
    debugPrint('emitindo evento $this');

    //DDIEvent.instance.fire<State>(state);
    DDIStream.instance.fire<State>(value: state);

    super.emit(state);
  }
}
