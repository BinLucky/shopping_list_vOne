import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppblocBloc extends Bloc<AppblocEvent, AppblocState> {
  AppblocBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AppblocState.authenticated(authenticationRepository.currentUser)
            : const AppblocState.unauthenticated()) {
    on<LogOutRequest>(_logOutRequest);
    on<UserStatusChanged>(_userStatusChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _logOutRequest(LogOutRequest event, Emitter<AppblocState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  void _userStatusChanged(UserStatusChanged event, Emitter<AppblocState> emit) {
    emit(event.user.isNotEmpty
        ? AppblocState.authenticated(event.user)
        : AppblocState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
