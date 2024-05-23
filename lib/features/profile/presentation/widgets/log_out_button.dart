import 'package:edu_diary/core/service/edu_user.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';

Widget loginLogOutButton(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 231, 231, 231),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Theme(
      data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text('Log out'),
        iconColor: Colors.black87,
        leading: const Icon(Icons.logout),
        trailing: const SizedBox(),
        onExpansionChanged: (value) {
          if (value) {
            sl<EduUser>().logOut();
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    ),
  );
}