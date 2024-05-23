import 'package:flutter/material.dart';

Widget expandedButton(
    {required String title, required String data, required IconData icon}) {
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
        title: Text(title),
        leading: Icon(icon),
        trailing: const SizedBox(),
        children: [
          ListTile(
            title: Text(data),
          )
        ],
      ),
    ),
  );
}
