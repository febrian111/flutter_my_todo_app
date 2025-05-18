import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository _taskRepository;

  UpdateTask(this._taskRepository);

  Future<void> execute(Task task) async {
    await _taskRepository.updateTask(task);
  }
}
