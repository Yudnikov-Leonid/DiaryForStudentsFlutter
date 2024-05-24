import 'package:flutter/material.dart';

Widget menuTitleWidget() {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diary',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          'Unofficial edu43 client',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    ),
    IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
  ]);
}
