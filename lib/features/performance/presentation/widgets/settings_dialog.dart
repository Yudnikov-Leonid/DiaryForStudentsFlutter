import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PerformanceSettingsDialog extends StatelessWidget {
  const PerformanceSettingsDialog(this._context, {super.key});
  final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PerformanceBloc>(_context),
      child:
          BlocBuilder<PerformanceBloc, PerformanceState>(builder: (_, state) {
        if (state is PerformanceSuccess) {
          return _dialog(context, state.settings!);
        } else {
          return const SizedBox();
        }
      }),
    );
  }

  Widget _dialog(BuildContext context, (int, int) settings) {
    final locale = AppLocalizations.of(context)!;
    return Dialog(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            locale.settings,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.sort),
              DropdownButton(
                  value: settings.$1,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(locale.by_name),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text(locale.by_average),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text(locale.by_marks_count),
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
              Text(locale.sort_order),
              DropdownButton(
                  value: settings.$2,
                  items: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(locale.asc),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text(locale.desc),
                    )
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _context
                          .read<PerformanceBloc>()
                          .add(ChangeSortOrderSettingsEvent(value));
                    }
                  })
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(_context, rootNavigator: true).pop();
              },
              child: Text(locale.close))
        ],
      ),
    ));
  }
}
