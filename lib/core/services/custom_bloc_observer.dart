import 'dart:developer'; // هنا log الرسمي
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // عشان kDebugMode

class CustomBlocObserver extends BlocObserver {
  void _log(String message) {
    if (kDebugMode) {
      log(message); // يطبع بس في debug
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log('Event => $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log('Change => $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log('Transition => $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log('Error => $error');
    super.onError(bloc, error, stackTrace);
  }
}
