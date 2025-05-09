import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/task.dart';
import '../../core/di/providers.dart';
import 'get_tasks.dart';

part 'add_task.g.dart';

@riverpod
class AddTask extends _$AddTask {
  @override
  Future<void> build() async {}

  Future<void> execute(Task task) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(taskRepositoryProvider).addTask(task);
      await ref.read(getTasksProvider.notifier).execute();
    });
  }
}
