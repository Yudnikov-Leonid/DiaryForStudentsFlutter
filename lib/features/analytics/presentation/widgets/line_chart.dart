import 'package:collection/collection.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/title_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarksLineChart extends StatelessWidget {
  MarksLineChart(this.values, this.labels, {super.key});

  final List<double> values;
  final List<String> labels;

  final List<Color> gradientColors = [
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
                interval: labels.length / 4,
                getTitlesWidget: (value, meta) =>
                    bottomTitleWidgets(value, meta, labels),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, false),
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
}
