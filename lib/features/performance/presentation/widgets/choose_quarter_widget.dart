import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseQuarterWidget extends StatelessWidget {
  final int _pos;

  const ChooseQuarterWidget(this._pos, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return SizedBox(
      height: 50,
      width: 100,
      child: DropdownButton(
        items: [
          DropdownMenuItem<int>(
            value: 1,
            child: Text(locale.first_quarter),
          ),
          DropdownMenuItem<int>(
            value: 2,
            child: Text(locale.second_quarter),
          ),
          DropdownMenuItem<int>(
            value: 3,
            child: Text(locale.third_quarter),
          ),
          DropdownMenuItem<int>(
            value: 4,
            child: Text(locale.fourth_quarter),
          )
        ],
        onChanged: (pos) {
          context.read<PerformanceBloc>().add(ChangeQuarterEvent(pos!));
        },
        value: _pos
      ),
    );
  }
}