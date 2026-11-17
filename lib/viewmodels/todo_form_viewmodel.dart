import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../domain/entities/todo_entity.dart';
import '../domain/repositories/todo_repository.dart';

sealed class TodoFormState extends Equatable {
  const TodoFormState();

  @override
  List<Object?> get props => [];
}

final class TodoFormInitial extends TodoFormState {
  final String title;
  final String description;

  const TodoFormInitial({
    this.title = '',
    this.description = '',
  });

  @override
  List<Object?> get props => [title, description];
}

final class TodoFormSaving extends TodoFormState {
  const TodoFormSaving();
}

final class TodoFormSuccess extends TodoFormState {
  const TodoFormSuccess();
}

final class TodoFormError extends TodoFormState {
  final String message;

  const TodoFormError(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoFormViewModel extends ChangeNotifier {
  final TodoRepository repository;

  String _title = '';
  String _description = '';
  TodoFormState _state = const TodoFormInitial();

  TodoFormViewModel({required this.repository});

  TodoFormState get state => _state;
  String get title => _title;
  String get description => _description;

  void initWithTodo(Todo? todo) {
    if (todo != null) {
      _title = todo.title;
      _description = todo.description;
    } else {
      _title = '';
      _description = '';
    }
    _state = TodoFormInitial(title: _title, description: _description);
    notifyListeners();
  }

  void setTitle(String value) {
    _title = value;
  }

  void setDescription(String value) {
    _description = value;
  }

  Future<bool> saveForm(Todo? todoToEdit) async {
    if (_title.trim().isEmpty) {
      _state = const TodoFormError('Judul tugas tidak boleh kosong');
      notifyListeners();
      return false;
    }

    _state = const TodoFormSaving();
    notifyListeners();

    try {
      final currentTodos = List<Todo>.of(await repository.fetchTodos());
      if (todoToEdit != null) {
        final index = currentTodos.indexWhere((t) => t.id == todoToEdit.id);
        if (index != -1) {
          currentTodos[index] = todoToEdit.copyWith(
            title: _title.trim(),
            description: _description.trim(),
          );
        }
      } else {
        final newTodo = Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _title.trim(),
          description: _description.trim(),
          createdAt: DateTime.now(),
        );
        currentTodos.insert(0, newTodo);
      }

      await repository.saveTodos(currentTodos);
      _state = const TodoFormSuccess();
      notifyListeners();
      return true;
    } catch (e) {
      _state = TodoFormError('Gagal menyimpan tugas: $e');
      notifyListeners();
      return false;
    }
  }
}