import 'package:edu_diary/core/constants/marks_colors.dart';
import 'package:edu_diary/features/diary/domain/entity/lesson.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LessonDetails extends StatelessWidget {
  const LessonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final lesson = ModalRoute.of(context)!.settings.arguments as DiaryLesson;
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.lesson_details),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Text(locale.share_homework),
                        content: Text(locale.choose_share_type),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                final text =
                                    '${lesson.lessonName} (${lesson.date})\n\n${locale.actual_homework}: ${lesson.homework ?? ''}';
                                Share.share(text);
                              },
                              child: Text(locale.actual)),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                final text =
                                    '${lesson.lessonName} (${lesson.date})\n\n${locale.previous_homework}: ${lesson.previousHomework ?? ''}';
                                Share.share(text);
                              },
                              child: Text(locale.previous)),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                final text =
                                    '${lesson.lessonName} (${lesson.date})\n\n${locale.actual_homework}: ${lesson.homework ?? ''}\n\n${locale.previous_homework}: ${lesson.previousHomework ?? ''}';
                                Share.share(text);
                              },
                              child: Text(locale.all)),
                        ],
                      ));
            },
            icon: const Icon(Icons.share_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.lessonName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${lesson.lessonNumber} lesson',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              lesson.teacherName,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 40,
            ),
            lesson.topic == null
                ? const SizedBox()
                : const Text(
                    'Topic',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
            lesson.topic == null
                ? const SizedBox()
                : Text(
                    lesson.topic!,
                    style: const TextStyle(fontSize: 18),
                  ),
            const SizedBox(
              height: 20,
            ),
            lesson.homework == null
                ? const SizedBox()
                : const Text(
                    'Homework',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
            lesson.homework == null
                ? const SizedBox()
                : Text(
                    lesson.homework!,
                    style: const TextStyle(fontSize: 18),
                  ),
            const SizedBox(
              height: 20,
            ),
            lesson.previousHomework == null || (lesson.previousHomework?.isEmpty ?? true)
                ? const SizedBox()
                : const Text(
                    'Previous homework',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
            lesson.previousHomework == null || (lesson.previousHomework?.isEmpty ?? true)
                ? const SizedBox()
                : Text(
                    lesson.previousHomework!,
                    style: const TextStyle(fontSize: 18),
                  ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lesson.marks.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          lesson.marks[index].toString(),
                          style: TextStyle(
                              color:
                                  MarkColors.handleColor(lesson.marks[index])),
                        ),
                      )),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: lesson.notes.length,
                  itemBuilder: (context, index) => Text(lesson.notes[index])),
            )
          ],
        ),
      ),
    );
  }
}
