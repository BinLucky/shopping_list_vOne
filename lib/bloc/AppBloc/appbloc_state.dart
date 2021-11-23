part of 'appbloc_bloc.dart';

enum AppStatur { authenticated, unauthenticated }

@immutable
abstract class AppblocState extends Equatable {}

class AppblocInitial extends AppblocState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
