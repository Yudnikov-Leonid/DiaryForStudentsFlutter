import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarksLineChart extends StatelessWidget {
  MarksLineChart(this.values, this.labels, {super.key});

  final List<double> values;
  final List<String> labels;

  List<Color> gradientColors = [
    Colors.greenAccent,
    Colors.green.shade500,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: leftTitleWidgets,
                reservedSize: 42,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.grey, width: 2),
              left: BorderSide(color: Colors.grey, width: 2),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors,
                ),
                barWidth: 6,
                spots: values
                    .mapIndexed((i, point) => FlSpot(i.toDouble(), point))
                    .toList(),
                isCurved: true,
                dotData: const FlDotData(show: false))
          ])),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    return Text(
      labels[value.toInt()],
      style: const TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      value.toString(),
      style: TextStyle(
          color: Colors.green.shade300,
          fontWeight: FontWeight.bold,
          fontSize: 14),
    );
  }
}
