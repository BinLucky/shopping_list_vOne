part of 'appbloc_bloc.dart';

@immutable
abstract class AppblocEvent extends Equatable {}

class LogOutRequest extends AppblocEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserStatusChanged extends AppblocEvent {
  UserStatusChanged(this.user);
  final User user;

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
