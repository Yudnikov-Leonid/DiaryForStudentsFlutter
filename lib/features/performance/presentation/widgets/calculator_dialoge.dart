import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/mark.dart';
import 'package:flutter/material.dart';

class CalculatorDialog extends StatefulWidget {
  CalculatorDialog(this._lesson, {super.key});

  final LessonEntity _lesson;

  @override
  State<CalculatorDialog> createState() => _CalculatorDialogState();
}

class _CalculatorDialogState extends State<CalculatorDialog> {
  List<int> _marks = [];

  @override
  void initState() {
    _marks = widget._lesson.marks.map((e) => e.value).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Calculator',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(height: 70, child: Expanded(child: _marksList(_marks))),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_buttons('Add', true), _buttons('Remove', false)],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Average = ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  _getAverage().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: PerformanceResponse.handleAverageColor(
                          _getAverage())),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _getAverage() {
    if (_marks.isEmpty) return 0;
    return (_marks.reduce((a, b) => a + b) / _marks.length * 100).round() / 100;
  }

  Widget _buttons(String title, bool add) {
    return Column(children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      Row(
        children: [
          _button('5', Colors.greenAccent.shade400, () {
            setState(() {
              if (add) {
                _marks.add(5);
              } else {
                _marks = _marks.reversed.toList();
                _marks.remove(5);
                _marks = _marks.reversed.toList();
              }
            });
          }),
          const SizedBox(
            width: 5,
          ),
          _button('4', Colors.green, () {
            setState(() {
              if (add) {
                _marks.add(4);
              } else {
                _marks = _marks.reversed.toList();
                _marks.remove(4);
                _marks = _marks.reversed.toList();
              }
            });
          }),
          const SizedBox(
            width: 5,
          ),
          _button('3', Colors.yellow.shade700, () {
            setState(() {
              if (add) {
                _marks.add(3);
              } else {
                _marks = _marks.reversed.toList();
                _marks.remove(3);
                _marks = _marks.reversed.toList();
              }
            });
          })
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          _button('2', Colors.red, () {
            setState(() {
              if (add) {
                _marks.add(2);
              } else {
                _marks = _marks.reversed.toList();
                _marks.remove(2);
                _marks = _marks.reversed.toList();
              }
            });
          }),
          const SizedBox(
            width: 5,
          ),
          _button('1', Colors.red, () {
            setState(() {
              if (add) {
                _marks.add(1);
              } else {
                _marks = _marks.reversed.toList();
                _marks.remove(1);
                _marks = _marks.reversed.toList();
              }
            });
          })
        ],
      )
    ]);
  }

  Widget _button(String text, Color color, Function action) {
    return SizedBox(
        height: 40,
        width: 40,
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade50,
                alignment: Alignment.center),
            onPressed: () {
              action();
            },
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: color, fontSize: 20),
            )));
  }

  Widget _marksList(List<int> marks) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: marks.length,
        itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(3),
              margin: const EdgeInsets.all(6),
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withAlpha(30),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 0))
                  ]),
              child: Text(
                marks[index].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: PerformanceResponse.handleColor(marks[index])),
              ),
            ));
  }
}
