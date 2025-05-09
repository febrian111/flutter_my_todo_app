import 'package:my_todo_app/domain/entities/task.dart';
import 'package:my_todo_app/domain/usecases/get_tasks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  @override
  AsyncValue<List<Task>> build() {
    // Initialize by loading tasks
    _loadTasks();
    return const AsyncValue.loading();
  }

  Future<void> _loadTasks() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await ref.read(getTasksProvider.future);
    });
  }
}
