import 'package:flutter/material.dart';
import 'package:shopping_list_vone/cubit/login_cubit.dart';
import 'package:sign_button/sign_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(listener: (context, state) {
      if (state.status.isSubmissinFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failed')),
          );
      }
    });
  }
}

class _emailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "User mail",
          hintText: "Type your e-mail adress",
          hintStyle: TextStyle(height: 1.5),
          prefixIcon: Icon(Icons.person, color: Colors.grey)),
      autofocus: true,
      //validator: mailValidator,
    );
  }
}

class _passwordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "User password",
        hintText: "Type your password",
        hintStyle: TextStyle(height: 1.5),
        prefixIcon: Icon(Icons.lock, color: Colors.grey),
      ),
      //validator: passwordValidator,
    );
  }
}

class _loginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      child: Text("Login"),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.brown.shade300),
          fixedSize: MaterialStateProperty.all(Size(250, 50))),
      onPressed: () {},
    );
  }
}
/*
ListView(children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            child: const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 32),
            ),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "User mail",
                          hintText: "Type your e-mail adress",
                          hintStyle: TextStyle(height: 1.5),
                          prefixIcon: Icon(Icons.person, color: Colors.grey)),
                      autofocus: true,
                      //validator: mailValidator,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "User password",
                        hintText: "Type your password",
                        hintStyle: TextStyle(height: 1.5),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      ),
                      //validator: passwordValidator,
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: ElevatedButton(
                child: Text("Login"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.brown.shade300),
                    fixedSize: MaterialStateProperty.all(Size(250, 50))),
                onPressed: () {
                  _formKey.currentState!.validate();
                },
              ),
            ),
          ),
          const SizedBox(
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
*/ 