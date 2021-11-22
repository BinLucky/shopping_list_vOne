import 'package:equatable/equatable.dart';

class User extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  const User({required this.id, this.email, this.name});
  final String? name;
  final String id;
  final String? email;

  static const empty = User(id: "");

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
}
