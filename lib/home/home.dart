import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_vone/app/bloc/appbloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:shopping_list_vone/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //return BlocBuilder<AppBloc, AppblocState>(builder: (context, state) {})
    return BlocListener<AppBloc, AppblocState>(
      listenWhen: (previous, current) => current != previous,
      listener: (context, state) {
        if (context.read<AppStatus>() != AppStatus.authenticated) {
          debugPrint("User is not Authenticated");
        }
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("HomePage"),
          ),
          body: Center(
            child: Column(children: [
              Text(
                "Home Page",
                style: TextStyle(fontSize: 35),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AppBloc>().add(LogOutRequest());
                  },
                  child: Text("LogOut")),
              _TestButton()
            ]),
          ),
        ),
      ),
    );
  }
}

class _TestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        onPressed: () {
          debugPrint(context.read<AppBloc>().state.appStatus.toString());
        },
        child: Text("Test Button"));
  }
}
