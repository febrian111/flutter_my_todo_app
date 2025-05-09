import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/task_repository.dart';
import '../../core/di/providers.dart';
import 'get_tasks.dart';

part 'delete_task.g.dart';

@riverpod
class DeleteTask extends _$DeleteTask {
  @override
  Future<void> build() async {}

  Future<void> execute(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(taskRepositoryProvider).deleteTask(id);
      await ref.read(getTasksProvider.notifier).execute();
    });
  }
}
