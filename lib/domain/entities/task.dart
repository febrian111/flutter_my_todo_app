import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  Task({
    String? id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Task copyWith({String? title, String? description, bool? isCompleted}) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }
}
