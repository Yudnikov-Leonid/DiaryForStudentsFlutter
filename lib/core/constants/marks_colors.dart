import 'package:flutter/material.dart';

class MarkColors {
  static const fiveColor = Color.fromARGB(255, 33, 255, 55);
  static const fourColor = Colors.green;
  static const threeColor = Color.fromARGB(255, 255, 203, 71);
  static const twoColor = Color.fromARGB(255, 255, 10, 10);
  static const oneColor = Color.fromARGB(255, 184, 5, 5);

  static Color handleColor(int value) {
    switch (value) {
      case 5:
        return MarkColors.fiveColor;
      case 4:
        return MarkColors.fourColor;
      case 3:
        return MarkColors.threeColor;
      case 2:
        return MarkColors.twoColor;
      case 1:
        return MarkColors.oneColor;
      default:
        return Colors.black;
    }
  }

  static Color handleAverageColor(double value) {
    switch (value) {
      case >= 4.5:
        return MarkColors.fiveColor;
      case >= 3.5:
        return MarkColors.fourColor;
      case >= 2.5:
        return MarkColors.threeColor;
      case > 1:
        return MarkColors.twoColor;
      default:
        return MarkColors.oneColor;
    }
  }
}