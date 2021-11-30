import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/src/provider.dart';
import 'package:shopping_list_vone/cubit/login_cubit.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list_vone/pages/views/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Login page")),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: LoginView(),
          ),
        ));
  }
}
