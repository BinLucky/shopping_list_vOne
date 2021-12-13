import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:shopping_list_vone/signup/bloc/cubit/sign_up_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else {
          debugPrint("Hata");
        }
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            SizedBox(height: 8),
            _PasswordInput(),
            SizedBox(height: 8),
            _ConfirmPassword(),
            SizedBox(height: 8),
            _SignUpButton()
          ],
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder(builder: (context, state) {
      return ElevatedButton(
        child: Text("Sign Up"),
        onPressed: () => context.read<SignUpCubit>().signUpFormSubmitted(),
      );
    });
  }
}

class _ConfirmPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return TextFormField(
            onChanged: (confirmedPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(confirmedPassword),
            decoration: InputDecoration(
                hintText: "Type your password",
                prefixIcon: Icon(Icons.lock_outline_sharp, color: Colors.grey),
                errorText:
                    state.password.invalid ? "Password is invalid" : null),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextFormField(
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            decoration: InputDecoration(
                hintText: "Type your password",
                prefixIcon: Icon(Icons.lock_outline_sharp, color: Colors.grey),
                errorText:
                    state.password.invalid ? "Password is invalid" : null),
          );
        });
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
            key: Key("signUpForm_emailForm_key"),
            decoration: InputDecoration(
                hintText: "Type your e-mail adress",
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                errorText: state.email.invalid ? "Email is Invalid" : null),
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(email),
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
          );
        });
  }
}
/*import 'package:flutter/material.dart';
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
*/