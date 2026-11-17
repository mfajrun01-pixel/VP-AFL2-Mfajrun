import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../domain/entities/todo_entity.dart';
import '../domain/repositories/todo_repository.dart';

enum TodoFilter { all, active, completed }

sealed class TodoListState extends Equatable {
  const TodoListState();

  @override
  List<Object?> get props => [];
}

final class TodoListInitial extends TodoListState {
  const TodoListInitial();
}

final class TodoListLoading extends TodoListState {
  const TodoListLoading();
}

final class TodoListLoaded extends TodoListState {
  final List<Todo> todos;
  final int totalCount;
  final int activeCount;
  final int completedCount;
  final String searchQuery;
  final TodoFilter currentFilter;

  const TodoListLoaded({
    required this.todos,
    required this.totalCount,
    required this.activeCount,
    required this.completedCount,
    required this.searchQuery,
    required this.currentFilter,
  });

  @override
  List<Object?> get props => [
    todos,
    totalCount,
    activeCount,
    completedCount,
    searchQuery,
    currentFilter,
  ];
}

final class TodoListError extends TodoListState {
  final String message;

  const TodoListError(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoListViewModel extends ChangeNotifier {
  final TodoRepository repository;

  List<Todo> _allTodos = [];
  String _searchQuery = '';
  TodoFilter _currentFilter = TodoFilter.all;
  TodoListState _state = const TodoListInitial();

  TodoListViewModel({required this.repository});

  TodoListState get state => _state;

  List<Todo> get todos {
    return _allTodos.where((todo) {
      final matchesSearch =
          todo.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              todo.description.toLowerCase().contains(_searchQuery.toLowerCase());

      switch (_currentFilter) {
        case TodoFilter.active:
          return matchesSearch && !todo.isCompleted;
        case TodoFilter.completed:
          return matchesSearch && todo.isCompleted;
        case TodoFilter.all:
          return matchesSearch;
      }
    }).toList();
  }

  int get totalCount => _allTodos.length;
  int get activeCount => _allTodos.where((t) => !t.isCompleted).length;
  int get completedCount => _allTodos.where((t) => t.isCompleted).length;
  String get searchQuery => _searchQuery;
  TodoFilter get currentFilter => _currentFilter;

  Future<void> loadTodos() async {
    _state = const TodoListLoading();
    notifyListeners();

    try {
      _allTodos = await repository.fetchTodos();
      _updateLoadedState();
    } catch (e) {
      _state = TodoListError('Gagal memuat daftar tugas: $e');
      notifyListeners();
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      _allTodos = await repository.toggleTodo(id, _allTodos);
      _updateLoadedState();
    } catch (e) {
      _state = TodoListError('Gagal mengubah status tugas: $e');
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _allTodos = await repository.deleteTodo(id, _allTodos);
      _updateLoadedState();
    } catch (e) {
      _state = TodoListError('Gagal menghapus tugas: $e');
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _updateLoadedState();
  }

  void setFilter(TodoFilter filter) {
    _currentFilter = filter;
    _updateLoadedState();
  }

  void _updateLoadedState() {
    _state = TodoListLoaded(
      todos: todos,
      totalCount: totalCount,
      activeCount: activeCount,
      completedCount: completedCount,
      searchQuery: _searchQuery,
      currentFilter: _currentFilter,
    );
    notifyListeners();
  }
}