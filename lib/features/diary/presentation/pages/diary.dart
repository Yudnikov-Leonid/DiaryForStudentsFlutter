import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_bloc.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_event.dart';
import 'package:edu_diary/features/diary/presentation/bloc/diary_state.dart';
import 'package:edu_diary/features/diary/presentation/widgets/lesson_widget.dart';
import 'package:edu_diary/features/diary/presentation/widgets/week_widget.dart';
import 'package:edu_diary/sl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class DiaryPage extends StatelessWidget {
  DiaryPage({super.key});

  final _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiaryBloc>(
        create: (context) => sl()..add(DiaryInitialEvent()),
        child: BlocBuilder<DiaryBloc, DiaryState>(builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Diary'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  title: const Text('Share homework'),
                                  content: const Text('Choose what to share'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          if (state is DiaryLoadedState) {
                                            final text =
                                                'Homework from ${state.date}\n\n${state.day.homeworkToShare}';
                                            Share.share(text);
                                          }
                                        },
                                        child: const Text('Actual')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          if (state is DiaryLoadedState) {
                                            final text =
                                                'Actual homework on ${state.date}\n\n${state.day.previousHomeworkToShare}';
                                            Share.share(text);
                                          }
                                        },
                                        child: const Text('Previous')),
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.share))
                ],
              ),
              body: _buildBody(state, context));
        }));
  }

  Widget _buildBody(DiaryState state, BuildContext context) {
    if (state is DiaryLoadedState) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.title,
                style: const TextStyle(fontSize: 20),
              ),
              IconButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateFormat('dd.MM.yyyy').parse(state.date),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));
                    if (picked != null) {
                      context.read<DiaryBloc>().add(DiarySelectDayEvent(
                          DateFormat('dd.MM.yyyy').format(picked)));
                    }
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: PageView(
              onPageChanged: (value) {
                if (value == 0) {
                  context.read<DiaryBloc>().add(DiaryPreviousWeek());
                  _pageController.jumpToPage(1);
                } else if (value == 2) {
                  context.read<DiaryBloc>().add(DiaryNextWeek());
                  _pageController.jumpToPage(1);
                }
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                weekWidget(state.dates.$1, -1, context),
                weekWidget(state.dates.$2, state.selectedDate, context),
                weekWidget(state.dates.$3, -1, context),
              ],
            ),
          ),
          Expanded(
              child: state.day.lessons.isEmpty
                  ? const Center(
                      child: Text(
                      'No data',
                      style: TextStyle(fontSize: 18),
                    ))
                  : _lessonList(state.day.lessons))
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
  }

  Widget _lessonList(List<DiaryLesson> lessons) {
    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) =>
            diaryLessonWidget(lessons[index], context));
  }
}
