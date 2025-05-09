import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required DateTime createdAt,
  }) : super(
         id: id,
         title: title,
         description: description,
         isCompleted: isCompleted,
         createdAt: createdAt,
       );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
    );
  }
}
