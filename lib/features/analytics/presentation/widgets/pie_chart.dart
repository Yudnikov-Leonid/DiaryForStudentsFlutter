import 'package:collection/collection.dart';
import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MarksPieChart extends StatefulWidget {
  const MarksPieChart(this.data, {super.key});

  final List<int> data;

  @override
  State<MarksPieChart> createState() => _MarksPieChartState();
}

class _MarksPieChartState extends State<MarksPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Center(
            child: Text('${widget.data.fold(0, (a, b) => a + b)} in total'),
          ),
          PieChart(PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            sections: _sections(),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 60,
          )),
        ],
      ),
    );
  }

  List<PieChartSectionData> _sections() {
    return widget.data.mapIndexed((i, count) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 70.0 : 60.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: PerformanceResponse.handleColor(i + 1),
        value: count.toDouble(),
        title: '$count',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
