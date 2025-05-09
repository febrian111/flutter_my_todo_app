import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/task.dart';
import '../../core/di/providers.dart';

part 'get_tasks.g.dart';

@riverpod
class GetTasks extends _$GetTasks {
  @override
  Future<List<Task>> build() {
    final repository = ref.watch(taskRepositoryProvider);
    return repository.getTasks();
  }

  Future<void> execute() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(taskRepositoryProvider).getTasks(),
    );
  }
}
