import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerformanceSettingsDialog extends StatelessWidget {
  const PerformanceSettingsDialog(this._context, {super.key});
  final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PerformanceBloc>(_context),
      child:
          BlocBuilder<PerformanceBloc, PerformanceState>(builder: (_, state) {
        print('settings: ${state.settings}');
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
                  onChanged: (value) {
                    if (value != null) {
                      _context
                          .read<PerformanceBloc>()
                          .add(ChangeSortSettingsEvent(value));
                    }
                  })
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
          TextButton(onPressed: () {
            Navigator.of(_context, rootNavigator: true).pop();
          }, child: const Text('Close'))
        ],
      ),
    ));
  }
}
