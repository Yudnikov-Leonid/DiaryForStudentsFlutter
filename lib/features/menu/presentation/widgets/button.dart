import 'package:flutter/material.dart';

Widget menuButton(
    {required String text,
    required IconData icon,
    required bool isLoaded,
    required Color firstGradientColor,
    required Color secondGradientColor,
    required Function() action}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    height: 150,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        firstGradientColor,
        secondGradientColor,
      ]),
      borderRadius: const BorderRadius.all(Radius.circular(24)),
    ),
    child: InkWell(
      onTap: isLoaded
          ? () {
              action();
            }
          : null,
      child: Stack(
        children: [
          isLoaded
              ? Container()
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.grey.shade300,
                )),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Transform.rotate(
                    angle: 0.2,
                    child: Icon(
                      icon,
                      color: Colors.white.withAlpha(120),
                      size: 160,
                    ))),
          )
        ],
      ),
    ),
  );
}
