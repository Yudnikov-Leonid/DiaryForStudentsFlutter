import 'package:collection/collection.dart';
import 'package:edu_diary/core/constants/marks_colors.dart';
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
    final sum = widget.data.fold(0, (a, b) => a + b);
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.4,
          child: Stack(
            children: [
              Center(
                child: Text('$sum in total'),
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
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _markPercent(5, sum),
            const SizedBox(
              width: 8,
            ),
            _markPercent(4, sum),
            const SizedBox(
              width: 8,
            ),
            _markPercent(3, sum),
            const SizedBox(
              width: 8,
            ),
            _markPercent(2, sum),
            const SizedBox(
              width: 8,
            ),
            _markPercent(1, sum),
            const SizedBox(
              width: 8,
            ),
          ],
        )
      ],
    );
  }

  Widget _markPercent(int mark, int sum) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: MarkColors.handleColor(mark),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          '$mark (${(widget.data[mark - 1] / sum * 100).round()}%)',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  List<PieChartSectionData> _sections() {
    return widget.data.mapIndexed((i, count) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 70.0 : 60.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: MarkColors.handleColor(i + 1),
        value: count.toDouble(),
        title: '$count',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
        ),
      );
    }).toList();
  }
}
