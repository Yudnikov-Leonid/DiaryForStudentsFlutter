import 'package:flutter/material.dart';

Widget menuButton(
    {required String text,
    required IconData icon,
    required bool isLoaded,
    required Color firstGradientColor,
    required Color secondGradientColor,
    required Function() action,
    int? notification}) {
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
          Align(
            alignment: const Alignment(1.06, -1.6),
            child: notification != null && notification != 0 ? Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              child: Center(
                  child: Text(
                notification.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
            ): null,
          ),
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
