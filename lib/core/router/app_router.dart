import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/task.dart';
import '../../presentation/add_task/add_task_page.dart';
import '../../presentation/home/home_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/add', builder: (context, state) => const AddTaskPage()),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) {
          final taskId = state.pathParameters['id'] ?? '';
          final task = state.extra as Task?;
          return AddTaskPage(taskId: taskId, task: task);
        },
      ),
    ],
  );
}
