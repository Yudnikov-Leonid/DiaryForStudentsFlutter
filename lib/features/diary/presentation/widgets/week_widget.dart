import 'package:edu_diary/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget weekWidget(List<String> dates, int selected, BuildContext context) {
final locale = AppLocalizations.of(context)!;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _dayWidget(dates[0], locale.mon, false, selected == 1, context),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[1], locale.tue, false, selected == 2, context),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[2], locale.wed, false, selected == 3, context),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[3], locale.thu, false, selected == 4, context),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[4], locale.fri, false, selected == 5, context),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[5], locale.san, true, selected == 6, context),
      const SizedBox(
        width: 10,
      ),
      _dayWidget(dates[6], locale.sat, true, selected == 7, context),
    ],
  );
}

Widget _dayWidget(
    String date, String weekDay, bool isWeekend, bool isSelected, BuildContext context) {
  return InkWell(
    onTap: () {
      context.read<DiaryBloc>().add(DiarySelectDayEvent(date));
    },
    child: Container(
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
    ),
  );
}
