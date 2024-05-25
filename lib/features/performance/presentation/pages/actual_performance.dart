import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:edu_diary/features/performance/presentation/widgets/choose_quarter_widget.dart';
import 'package:edu_diary/features/performance/presentation/widgets/lesson_widget.dart';
import 'package:edu_diary/features/performance/presentation/widgets/settings_dialog.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActualPerformancePage extends StatelessWidget {
  const ActualPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PerformanceBloc>(
        create: (context) => sl()..add(const GetLessonsEvent()),
        child: _buildBody());
  }

  _buildBody() {
    return BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
      if (state is PerformanceLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PerformanceFailed) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.error!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TextButton(onPressed: () {
              context.read<PerformanceBloc>().add(const GetLessonsEvent());
            }, child: const Text('Retry'))
          ],
        );
      } else if (state is PerformanceSuccess) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChooseQuarterWidget(state.quarter!),
                )),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => PerformanceSettingsDialog(context));
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.lessons!.length,
                itemBuilder: (context, index) {
                  return LessonWidget(state.lessons![index]);
                },
              ),
            ),
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
