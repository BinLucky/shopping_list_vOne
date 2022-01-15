import 'package:flutter/material.dart';
import 'package:shopping_list_vone/app/bloc/appbloc_bloc.dart';
import 'package:shopping_list_vone/signup/signup.dart';
import '../cubit/login_cubit.dart';
import 'package:sign_button/sign_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failed')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              _emailInput(),
              const SizedBox(height: 8),
              _passwordInput(),
              const SizedBox(height: 8),
              _loginInput(),
              const SizedBox(height: 8),
              _signUpInput(),
              const SizedBox(height: 8),
              _socialGroup(),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _signUpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.brown.shade300),
          fixedSize: MaterialStateProperty.all(Size(250, 50))),
      onPressed: () {
        debugPrint("Button Clicked");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignUp()));
      },
      child: Text("SignUp"),
    );
  }
}

class _socialGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [_loginWithGoogle()]);
  }
}

class _emailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previus, current) => previus.email != current.email,
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
              labelText: "User mail",
              hintText: "Type your e-mail adress",
              hintStyle: TextStyle(height: 1.5),
              prefixIcon: Icon(Icons.person, color: Colors.grey)),
          autofocus: true,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _passwordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextFormField(
            decoration: const InputDecoration(
              labelText: "User password",
              hintText: "Type your password",
              hintStyle: TextStyle(height: 1.5),
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
            ),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
          );
        });
  }
}

class _loginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previus, current) => previus != current,
        builder: (context, state) => state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                child: Text("Login"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.brown.shade300),
                    fixedSize: MaterialStateProperty.all(Size(250, 50))),
                onPressed: () {
                  if (state.status.isValidated) {
                    context
                        .read<LoginCubit>()
                        .logInWithCredentials()
                        .then((value) {
                      if (value != null) {
                        debugPrint(context
                                .read<LoginCubit>()
                                .getLoggedUser()
                                .email
                                .toString() +
                            " Cachelenen User");
                        context.read<AppBloc>().add(UserStatusChanged(value));
                      } else {
                        debugPrint("Current user is null");
                      }
                    });
                  } else {
                    //errorPrint()
                    debugPrint("Fuck1");
                  }
                }));
  }
}

class _loginWithGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInButton.mini(
      buttonType: ButtonType.google,
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}
