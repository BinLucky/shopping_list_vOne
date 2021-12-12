part of 'appbloc_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

class AppblocState extends Equatable {
  const AppblocState._({required this.appStatus, this.user = User.empty});

  const AppblocState.authenticated(User user)
      : this._(appStatus: AppStatus.authenticated, user: user);
  const AppblocState.unauthenticated()
      : this._(appStatus: AppStatus.unauthenticated);
  final User user;
  final AppStatus appStatus;

  @override
  // TODO: implement props
  List<Object?> get props => [user,appStatus];
}
