import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? userName;

  const User({required this.id, this.email, this.userName});
  static const empty = User(id: '');
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
