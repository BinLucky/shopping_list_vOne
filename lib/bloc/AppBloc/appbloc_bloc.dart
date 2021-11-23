import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppblocBloc extends Bloc<AppblocEvent, AppblocState> {
  AppblocBloc() : super(AppblocInitial()) {
    on<AppblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
