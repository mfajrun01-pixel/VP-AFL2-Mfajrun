import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../services/todo_storage_service.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoStorageService _storageService;

  TodoRepositoryImpl({TodoStorageService? storageService})
      : _storageService = storageService ?? TodoStorageService();

  @override
  Future<List<Todo>> fetchTodos() async {
    return await _storageService.loadTodos();
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    await _storageService.saveTodos(todos);
  }

  @override
  Future<List<Todo>> toggleTodo(String id, List<Todo> currentTodos) async {
    return await _storageService.toggleTodoStatus(id, currentTodos);
  }

  @override
  Future<List<Todo>> deleteTodo(String id, List<Todo> currentTodos) async {
    return await _storageService.deleteTodo(id, currentTodos);
  }
}