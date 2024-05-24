import 'package:edu_diary/features/analytics/presentation/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton(
              items: const [
                DropdownMenuItem<int>(value: 1, child: Text('First quarter')),
                DropdownMenuItem<int>(value: 2, child: Text('Second quarter')),
                DropdownMenuItem<int>(value: 3, child: Text('Third quarter')),
                DropdownMenuItem<int>(value: 4, child: Text('Fourth quarter')),
                DropdownMenuItem<int>(value: 5, child: Text('Year')),
              ],
              onChanged: (value) {},
              value: 1,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Average progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            MarksLineChart(const [
              (0, 4.4),
              (1, 3.9),
              (2, 4.12),
              (3, 4.01),
              (4, 3.88),
              (5, 4),
              (6, 3.8)
            ], const [
              '1 day',
              '2 day',
              '3 day',
              '4 day',
              '5 day',
              '6 day',
              '7 day',
            ]),
          ],
        ),
      )),
    );
  }
}
