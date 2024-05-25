import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta, List<String> labels) {
  return Text(
    labels[value.toInt()],
    style: const TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta, bool round) {
  return Text(
    round ? value.round().toInt().toString() : value.toString(),
    style: TextStyle(
        color: Colors.green.shade300,
        fontWeight: FontWeight.bold,
        fontSize: 14),
  );
}
