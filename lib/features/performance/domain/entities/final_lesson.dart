import 'package:equatable/equatable.dart';

class FinalLessonEntity extends Equatable {
  final String lessonName;
  final List<int?> marks;

  const FinalLessonEntity(this.lessonName, this.marks);

  @override
  List<Object?> get props => [lessonName, marks];
}
