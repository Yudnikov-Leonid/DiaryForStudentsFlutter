import 'package:edu_diary/features/login/presentation/bloc/login_bloc.dart';
import 'package:edu_diary/features/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget loginInputField(BuildContext context,
    {required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String error,
    required bool isEnabled,
    bool isPassword = false}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(16))),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          errorText: error.isEmpty ? null : error),
      obscureText: isPassword,
      readOnly: !isEnabled,
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginHideErrorsEvent());
      },
    ),
  );
}
