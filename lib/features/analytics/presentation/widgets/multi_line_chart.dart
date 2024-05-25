import 'dart:math';

import 'package:collection/collection.dart';
import 'package:edu_diary/core/constants/marks_colors.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/title_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarksMultiLineChart extends StatelessWidget {
  const MarksMultiLineChart(this.values, this.labels, {super.key});

  final List<List<int>> values;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: values.last.reduce(max) / 5,
                  getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, true),
                  reservedSize: 42,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: labels.length / 4,
                  getTitlesWidget: (value, meta) =>
                      bottomTitleWidgets(value, meta, labels),
                ),
              )),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.grey, width: 2),
              left: BorderSide(color: Colors.grey, width: 2),
              right: BorderSide(color: Colors.transparent),
              top: BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: _listLineChartData())),
    );
  }

  List<LineChartBarData> _listLineChartData() {
    final List<LineChartBarData> list = [];
    if (values.last[0] != 0) {
      list.add(_lineChartData(1));
    }
    if (values.last[1] != 0) {
      list.add(_lineChartData(2));
    }
    if (values.last[2] != 0) {
      list.add(_lineChartData(3));
    }
    if (values.last[3] != 0) {
      list.add(_lineChartData(4));
    }
    if (values.last[4] != 0) {
      list.add(_lineChartData(5));
    }
    return list;
  }
 
  LineChartBarData _lineChartData(int mark) {
    return LineChartBarData(
        color: MarkColors.handleColor(mark),
        barWidth: 6,
        spots: values
            .mapIndexed((i, data) => FlSpot(i.toDouble(), data[mark -1].toDouble()))
            .toList(),
        isCurved: true,
        dotData: const FlDotData(show: false));
  }
}
