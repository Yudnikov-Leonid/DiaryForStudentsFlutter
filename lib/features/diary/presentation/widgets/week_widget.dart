import 'package:flutter/material.dart';

Widget weekWidget(List<String> dates, int selected) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _dayWidget(dates[0], 'mon', false, selected == 0),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[1], 'tue', false, selected == 1),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[2], 'wed', false, selected == 2),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[3], 'thu', false, selected == 3),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[4], 'fri', false, selected == 4),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[5], 'san', true, selected == 5),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[6], 'sat', true, selected == 6),
    ],
  );
}

Widget _dayWidget(
    String date, String weekDay, bool isWeekend, bool isSelected) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
        ]),
    height: 80,
    width: 48,
    child: Column(
      children: [
        Text(
          weekDay,
          style: TextStyle(
              color: isSelected
                  ? (isWeekend ? Colors.red : Colors.blue)
                  : Colors.grey),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: isSelected
              ? BoxDecoration(
                  color: isWeekend ? Colors.red : Colors.blue,
                  borderRadius: BorderRadius.circular(8))
              : null,
          child: Center(
            child: Text(
              date.substring(0, 2),
              style: TextStyle(
                  fontSize: 16,
                  color: isSelected
                      ? Colors.white
                      : (isWeekend ? Colors.red : Colors.black),
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    ),
  );
}
