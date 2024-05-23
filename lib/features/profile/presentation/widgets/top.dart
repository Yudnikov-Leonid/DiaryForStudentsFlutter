import 'package:edu_diary/core/service/edu_user.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';

Widget loginTopWidget() {
  return Container(
    width: double.infinity,
    height: 280,
    decoration: const BoxDecoration(
        color: Color.fromARGB(255, 85, 155, 254),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32))),
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: ImageIcon(AssetImage('assets/images/businessman.png'),
                color: Colors.black, size: 140),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          sl<EduUser>().fullName(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    ),
  );
}