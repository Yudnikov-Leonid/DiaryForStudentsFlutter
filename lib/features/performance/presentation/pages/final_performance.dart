import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:edu_diary/features/performance/presentation/widgets/final_lesson_widget.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinalPerformancePage extends StatelessWidget {
  const FinalPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PerformanceBloc>(
        create: (context) => sl()..add(const GetFinalLessonsEvent()),
        child: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (_, state) {
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
          ],
        );
      } else if (state is PerformanceFinalSuccess) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.finalLessons!.length,
                itemBuilder: (context, index) {
                  return FinalLessonWidget(state.finalLessons![index]);
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