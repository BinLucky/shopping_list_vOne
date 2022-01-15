import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list_vone/app/bloc/appbloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:shopping_list_vone/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shopping List vOne"),
        ),
        body: Center(
          child: Column(children: [
            Text(
              "User Page",
              style: TextStyle(fontSize: 35),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30, 50, 30, 50),
              borderOnForeground: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Kullanıcı ID"), Text("Kullanıcı Mail")],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.read<AppBloc>().state.user.id.toString()),
                      Text(context.read<AppBloc>().state.user.email.toString())
                    ],
                  )
                ],
              ),
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
    );
    //);
  }
}

class _TestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          debugPrint(context.read<AppBloc>().state.appStatus.toString());
        },
        child: Text("Test Button"));
  }
}
