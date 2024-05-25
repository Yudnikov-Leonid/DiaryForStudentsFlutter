import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseQuarterWidget extends StatelessWidget {
  final int _pos;

  const ChooseQuarterWidget(this._pos, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: DropdownButton(
        items: const [
          DropdownMenuItem<int>(
            value: 1,
            child: Text('First'),
          ),
          DropdownMenuItem<int>(
            value: 2,
            child: Text('Second'),
          ),
          DropdownMenuItem<int>(
            value: 3,
            child: Text('Third'),
          ),
          DropdownMenuItem<int>(
            value: 4,
            child: Text('Fourth'),
          )
        ],
        onChanged: (pos) {
          context.read<PerformanceBloc>().add(ChangeQuarterEvent(pos!));
        },
        value: _pos,
        hint: const Text('Quarter'),
      ),
    );
  }
}