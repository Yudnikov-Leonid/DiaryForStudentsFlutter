import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:edu_diary/features/performance/presentation/widgets/calculator_dialoge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class LessonWidget extends StatelessWidget {
  final LessonEntity _lesson;

  const LessonWidget(this._lesson, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _lesson.lessonName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => CalculatorDialog(_lesson));
                  },
                  icon: const Icon(Icons.calculate_outlined))
            ],
          ),
          SizedBox(height: 98, child: _marksList(_lesson.marks)),
          Row(
            children: [
              const Text(
                'Average: ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                _lesson.average.toString(),
                style: TextStyle(
                    color:
                        PerformanceResponse.handleAverageColor(_lesson.average),
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _marksList(List<MarkEntity> marks) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: marks.length,
        itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(6),
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: marks[index].isChecked
                      ? null : Border.all(
                          color: PerformanceResponse.handleColor(marks[index].value),
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withAlpha(30),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0))
                  ]),
              child: Column(
                children: [
                  Text(
                    marks[index].date,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    marks[index].value.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: PerformanceResponse.handleColor(
                            marks[index].value)),
                  ),
                ],
              ),
            ));
  }
}
