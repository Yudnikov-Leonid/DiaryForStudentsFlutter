import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:edu_diary/features/performance/presentation/widgets/choose_quarter_widget.dart';
import 'package:edu_diary/features/performance/presentation/widgets/lesson_widget.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActualPerformancePage extends StatelessWidget {
  const ActualPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PerformanceBloc>(
        create: (context) => sl()..add(const GetLessonsEvent()),
        child: Scaffold(body: _buildBody()));
  }

  _buildBody() {
    return BlocBuilder<PerformanceBloc, PerformanceState>(
      builder: (bloc, state) {
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
            //TODO
            Icon(Icons.refresh)
          ],
        );
      } else if (state is PerformanceSuccess) {
        return Column(
          children: [
            ChooseQuarterWidget(state.quarter!),
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
