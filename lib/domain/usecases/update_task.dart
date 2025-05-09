import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../../core/di/providers.dart';
import 'get_tasks.dart';

part 'update_task.g.dart';

@riverpod
class UpdateTask extends _$UpdateTask {
  @override
  Future<void> build() async {}

  Future<void> execute(Task task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(taskRepositoryProvider).updateTask(task);
      await ref.read(getTasksProvider.notifier).execute();
    });
  }
}
