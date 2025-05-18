import '../repositories/task_repository.dart';

class DeleteTask {
  DeleteTask(this._taskRepository);

  final TaskRepository _taskRepository;

  Future<void> execute(String id) async {
    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 5));
    await _taskRepository.deleteTask(id);
  }
}
