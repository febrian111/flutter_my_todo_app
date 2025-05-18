import 'package:my_todo_app/domain/repositories/task_repository.dart';

import '../entities/task.dart';

// part 'add_task.g.dart';

class AddTask {
  final TaskRepository _taskRepository;

  AddTask(this._taskRepository);

  Future<void> execute(Task task) async {
    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 5));
    await _taskRepository.addTask(task);
  }
}
