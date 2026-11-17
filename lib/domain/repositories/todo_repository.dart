import '../entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> saveTodos(List<Todo> todos);
  Future<List<Todo>> toggleTodo(String id, List<Todo> currentTodos);
  Future<List<Todo>> deleteTodo(String id, List<Todo> currentTodos);
}