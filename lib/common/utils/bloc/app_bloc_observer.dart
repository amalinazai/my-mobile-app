import 'dart:developer';

import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log('[BLoC - onEvent]: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    log('[BLoC - onChange]: $bloc\n'
        '{Previous} ${change.currentState}\n'
        '{Next} ${change.nextState}');
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    log('[BLoC - onCreate]: $bloc');
    super.onCreate(bloc);
  }

  // @override
  // void onTransition(Bloc<dynamic, dynamic> bloc,
  //     Transition<dynamic, dynamic> transition,
  // ) {
  //   LoggerUtils.debug(
  //     '[BLoC - onTransition]:\n'
  //     '[Current State] ${transition.currentState}\n'
  //     '[Next State] ${transition.nextState}'
  //   );
  //   super.onTransition(bloc, transition);
  // }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('[BLoC - onError] ${bloc.toString}: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    log('[BLoC] onClose: $bloc');
    super.onClose(bloc);
  }
}
