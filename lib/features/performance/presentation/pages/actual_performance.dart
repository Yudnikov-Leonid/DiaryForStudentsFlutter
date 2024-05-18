import 'package:edu_diary/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_event.dart';
import 'package:edu_diary/features/performance/presentation/bloc/performance_state.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActualPerformance extends StatelessWidget {
  const ActualPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PerformanceBloc>(
        create: (context) => sl()..add(const GetLessonsEvent()),
        child: Scaffold(appBar: _buildAppBar(), body: _buildBody()));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Performance'),
    );
  }

  _buildBody() {
    return BlocBuilder<PerformanceBloc, PerformanceState>(builder: (_, state) {
      if (state is PerformanceLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PerformanceFailed) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.error!,
                textAlign: TextAlign.center,
              ),
            ),
            Icon(Icons.refresh)
          ],
        );
      } else if (state is PerformanceSuccess) {
        return ListView.builder(
          itemCount: state.lessons!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(state.lessons![index].lessonName),
            );
          },
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
