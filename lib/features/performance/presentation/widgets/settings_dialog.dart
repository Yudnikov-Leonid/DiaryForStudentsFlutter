import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget performanceSettingsDialog(BuildContext context) {
  return BlocProvider.value(
    value: BlocProvider.of<PerformanceBloc>(context),
    child: BlocBuilder<PerformanceBloc, PerformanceState>(builder: (_, state) {
      if (state is PerformanceSuccess) {
        return _dialog(state.settings!);
      } else {
        return const SizedBox();
      }
    }),
  );
}

Widget _dialog((int, int) settings) {
  return Dialog(
      child: Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16))),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Sort'),
            DropdownButton(
                value: settings.$1,
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('by name'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('by average'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('by marks count'),
                  )
                ],
                onChanged: (value) {})
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Sort order'),
            DropdownButton(
                value: settings.$2,
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('ASC'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('DESC'),
                  )
                ],
                onChanged: (value) {})
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(onPressed: () {}, child: const Text('Close'))
      ],
    ),
  ));
}
