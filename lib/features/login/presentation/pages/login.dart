import 'package:edu_diary/features/login/presentation/bloc/login_bloc.dart';
import 'package:edu_diary/features/login/presentation/bloc/login_event.dart';
import 'package:edu_diary/features/login/presentation/bloc/login_state.dart';
import 'package:edu_diary/features/login/presentation/widgets/input_field.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => sl(),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginInitialState) {
            return _loginPage(context, '', '', '', false);
          } else if (state is LoginLoginError) {
            return _loginPage(context, state.message, '', '', false);
          } else if (state is LoginPasswordError) {
            return _loginPage(context, '', state.message, '', false);
          } else if (state is LoginFailureState) {
            return _loginPage(context, '', '', state.message, false);
          } else if (state is LoginLoadingState) {
            return _loginPage(context, '', '', '', true);
          } else if (state is LoginSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacementNamed(context, '/menu');
            });
            return _loginPage(context, '', '', '', true);
          } else {
            return const Center(child: Text("Unknown state"));
          }
        }));
  }

  Widget _loginPage( BuildContext context,
      String loginError, String passwordError, String error, bool isLoading) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Login to your account',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 40,
              ),
              loginInputField(
                context,
                controller: _loginController,
                hint: 'Login',
                icon: Icons.email,
                error: loginError,
                isEnabled: !isLoading,
              ),
              const SizedBox(
                height: 20,
              ),
              loginInputField(
                context,
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.security,
                  error: passwordError,
                  isEnabled: !isLoading,
                  isPassword: true),
              const SizedBox(
                height: 40,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<LoginBloc>().add(LoginLoginEvent(
                            _loginController.text, _passwordController.text));
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(200, 50)),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )),
              _loadingIndicator(isLoading),
              const SizedBox(
                height: 95,
              ),
              Center(
                  child: Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 95,
              ),
              Center(
                  child: Column(
                children: [
                  const Text(
                    "Unofficial edu43 client",
                    style: TextStyle(
                        color: Colors.black26, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () async {
                        final uri = Uri.parse('https://vk.com/dorhun');
                        await launchUrl(uri);
                      },
                      child: const Text(
                        'Contacts',
                        style: TextStyle(color: Colors.blueGrey),
                      )),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

   Widget _loadingIndicator(bool isLoading) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Container();
    }
  }
}
