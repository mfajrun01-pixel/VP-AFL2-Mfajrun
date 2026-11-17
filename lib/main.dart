import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'data/services/todo_storage_service.dart';
import 'domain/repositories/todo_repository.dart';
import 'viewmodels/todo_list_viewmodel.dart';
import 'views/todo_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = TodoStorageService();
  final TodoRepository repository = TodoRepositoryImpl(storageService: storageService);
  final listViewModel = TodoListViewModel(repository: repository);

  runApp(MyApp(
    viewModel: listViewModel,
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final TodoListViewModel viewModel;
  final TodoRepository repository;

  const MyApp({
    super.key,
    required this.viewModel,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: TodoListScreen(
        viewModel: viewModel,
        repository: repository,
      ),
    );
  }
}
