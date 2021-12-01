import 'package:flutter/widgets.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_vone/app/bloc/appbloc_bloc.dart';

class App extends StatelessWidget {
  App({Key? key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(key: key);
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
            child: AppView()));
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
