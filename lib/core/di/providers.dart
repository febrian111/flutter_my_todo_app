import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_todo_app/data/datasources/task_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/task_local_datasource.dart';
import '../../data/datasources/task_remote_datasource.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/task_repository.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

part 'providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

@riverpod
Dio dio(Ref ref) {
  return DioClient().dio;
}

@riverpod
NetworkInfo networkInfo(Ref ref) {
  return NetworkInfoImpl();
}

@riverpod
TaskDataSource taskLocalDataSource(Ref ref) {
  return TaskLocalDataSourceImpl(ref.watch(sharedPreferencesProvider.future));
}

@riverpod
TaskDataSource taskRemoteDataSource(Ref ref) {
  return TaskRemoteDataSourceImpl(ref.watch(dioProvider));
}

@riverpod
TaskRepository taskRepository(Ref ref) {
  return TaskRepositoryImpl(
    localDataSource: ref.watch(taskLocalDataSourceProvider),
    remoteDataSource: ref.watch(taskRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}
