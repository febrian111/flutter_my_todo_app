import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/task.dart';
import '../task_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RefreshIndicator(
        onRefresh:
            () async => ref.read(taskViewModelProvider.notifier).refreshTasks(),
        child: tasksAsync.when(
          data: (tasks) {
            if (tasks.isEmpty) {
              return const Center(child: Text('No tasks yet. Add some!'));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItem(task: task);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends ConsumerWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(task.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        ref.read(taskViewModelProvider.notifier).deleteTask(task.id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('${task.title} deleted')));
      },
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            ref.read(taskViewModelProvider.notifier).toggleTaskCompletion(task);
          },
        ),
        onTap: () => context.go('/edit/${task.id}', extra: task),
      ),
    );
  }
}
