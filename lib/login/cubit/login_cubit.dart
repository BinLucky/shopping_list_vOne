import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_validators/form_validators.dart';
import 'package:formz/formz.dart';
import 'package:shopping_list_vone/app/bloc/appbloc_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginState());
  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, status: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password, status: Formz.validate([state.email, password])));
  }

  User getLoggedUser() {
    _authenticationRepository.user;
    User user = _authenticationRepository.currentUser;

    return user;
  }

  void testEvent() {
    debugPrint("LoginCubit Test");
  }

  Future<User?> logInWithCredentials() async {
    if (!state.status.isValidated) return null;
    debugPrint("Form is  Validated");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var user = await _authenticationRepository.logInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));

      return user;
    } catch (_) {
      debugPrint(_.toString());
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {}
  }
}
