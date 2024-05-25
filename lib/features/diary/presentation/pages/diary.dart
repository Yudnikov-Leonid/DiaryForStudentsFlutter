import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_state.dart';
import 'package:edu_diary/features/diary/presentation/widgets/lesson_widget.dart';
import 'package:edu_diary/features/diary/presentation/widgets/week_widget.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryPage extends StatelessWidget {
  DiaryPage({super.key});

  final _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiaryBloc>(
      create: (context) => sl()..add(DiaryInitialEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Diary'),
          centerTitle: true,
        ),
        body: BlocBuilder<DiaryBloc, DiaryState>(
          builder: (context, state) {
            if (state is DiaryLoadedState) {
              return Column(
                children: [
                  const Text(
                    'may 2024',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        weekWidget(state.dates.$1, -1),
                        weekWidget(state.dates.$2, state.selectedDate),
                        weekWidget(state.dates.$3, -1),
                      ],
                    ),
                  ),
                  Expanded(child: _lessonList(state.lessons))
                ],
              );
            } else if (state is DiaryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DiaryFailedState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              throw Exception('Unknown state');
            }
          },
        ),
      ),
    );
  }

  Widget _lessonList(List<DiaryLesson> lessons) {
    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) => diaryLessonWidget(lessons[index]));
  }
}
