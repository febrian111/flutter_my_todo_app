import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/task.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';

part 'task_viewmodel.g.dart';

@riverpod
class TaskViewModel extends _$TaskViewModel {
  @override
  AsyncValue<List<Task>> build() {
    // Initialize by loading tasks
    _loadTasks();
    return const AsyncValue.loading();
  }

  Future<void> _loadTasks() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final tasks = await ref.read(getTasksProvider.future);
      // return await ref.read(getTasksProvider.future);
      return tasks;
    });
  }

  Future<void> addTask(Task task) async {
    await ref.read(addTaskProvider.notifier).execute(task);
    // _loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await ref.read(updateTaskProvider.notifier).execute(task);
    _loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await ref.read(deleteTaskProvider.notifier).execute(id);
    _loadTasks();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    await updateTask(updatedTask);
  }

  void refreshTasks() {
    _loadTasks();
  }
}
