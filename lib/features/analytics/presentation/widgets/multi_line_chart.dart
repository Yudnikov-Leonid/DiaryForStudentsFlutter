import 'package:collection/collection.dart';
import 'package:edu_diary/core/constants/marks_colors.dart';
import 'package:edu_diary/features/analytics/presentation/widgets/title_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarksMultiLineChart extends StatelessWidget {
  const MarksMultiLineChart(this.values, this.labels, {super.key});

  final List<List<double>> values;
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
                  interval: 1,
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
          lineBarsData: [
            _lineChartData(1),
            _lineChartData(2),
            _lineChartData(3),
            _lineChartData(4),
            _lineChartData(5),
          ])),
    );
  }

  LineChartBarData _lineChartData(int mark) {
    return LineChartBarData(
        color: MarkColors.handleColor(mark),
        barWidth: 6,
        spots: values[mark - 1]
            .mapIndexed((i, point) => FlSpot(i.toDouble(), point))
            .toList(),
        isCurved: true,
        dotData: const FlDotData(show: false));
  }
}
