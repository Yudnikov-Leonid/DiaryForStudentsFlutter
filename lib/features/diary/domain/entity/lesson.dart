class DiaryLesson {
  final String lessonName;
  final String startTime;
  final String endTime;
  final String? topic;
  final String? homework;
  final String? previousHomework;
  final int lessonNumber;
  final String teacherName;
  final List<String> notes;
  final List<int> marks;

  DiaryLesson(this.lessonName, this.startTime, this.endTime, this.lessonNumber, this.topic, this.homework,
      this.previousHomework, this.teacherName, this.notes, this.marks);
}
