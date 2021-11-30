import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserCredentials usr = UserCredentials();
    final _formKey = GlobalKey<FormState>();
    late String _email;
    late String _password;

    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Center(
            child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            }
            if (state is RegisterRequestState) {
              CircularProgressIndicator();
            }
          },
          child: ListView(children: [
            Column(children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Sign In",
                style: TextStyle(color: Colors.blueGrey.shade800, fontSize: 24),
              ),
              Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                            decoration: InputDecoration(
                                hintText: "Type your e-mail adress",
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.grey)),
                            validator: mailValidator,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) {
                              email!.isNotEmpty ? _email = email : null;
                            }),
                        TextFormField(
                            decoration: InputDecoration(
                                hintText: "Type your password",
                                prefixIcon: Icon(Icons.lock_outline_sharp,
                                    color: Colors.grey)),
                            validator: passwordValidator,
                            onSaved: (password) {
                              password!.isNotEmpty
                                  ? _password = password
                                  : null;
                            })
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        registerBloc.add(UserRegisterEvent(
                            username: _email, password: _password));
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInButton.mini(
                      buttonType: ButtonType.google,
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                      buttonType: ButtonType.apple,
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                      buttonType: ButtonType.twitter,
                      onPressed: () {},
                    ),
                    SignInButton.mini(
                        buttonType: ButtonType.facebook, onPressed: () {})
                  ],
                ),
              )
            ]),
          ]),
        )),
      ),
    );
  }

  void waitAnimation() {
    CircularProgressIndicator();
  }
}
