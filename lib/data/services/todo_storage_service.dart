import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/todo_entity.dart';
import '../models/todo_model.dart';

class TodoStorageService {
  static const String _key = 'todos_storage_key';
  static const String _assetPath = 'assets/todos.json';

  final SharedPreferences? _prefs;

  TodoStorageService({SharedPreferences? prefs}) : _prefs = prefs;

  Future<SharedPreferences> get _instance async {
    return _prefs ?? await SharedPreferences.getInstance();
  }

  Future<List<Todo>> loadTodos() async {
    try {
      final p = await _instance;
      String? jsonString = p.getString(_key);

      if (jsonString == null || jsonString.trim().isEmpty) {
        try {
          jsonString = await rootBundle.loadString(_assetPath);
          await p.setString(_key, jsonString);
        } catch (_) {
          jsonString = '[]';
        }
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<Todo> todos = jsonList
          .map<Todo>(
            (item) => TodoModel.fromJson(item as Map<String, dynamic>),
      )
          .toList();

      return todos;
    } catch (e) {
      return <Todo>[];
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final p = await _instance;
    final jsonList = todos
        .map((todo) => TodoModel.fromEntity(todo).toJson())
        .toList();
    final jsonString = jsonEncode(jsonList);
    await p.setString(_key, jsonString);
  }

  Future<List<Todo>> toggleTodoStatus(String id, List<Todo> currentTodos) async {
    final updatedList = currentTodos.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          isCompleted: !todo.isCompleted,
          createdAt: todo.createdAt,
        );
      }
      return todo;
    }).toList();

    await saveTodos(updatedList);
    return updatedList;
  }

  Future<List<Todo>> deleteTodo(String id, List<Todo> currentTodos) async {
    final updatedList = currentTodos.where((todo) => todo.id != id).toList();
    await saveTodos(updatedList);
    return updatedList;
  }
}