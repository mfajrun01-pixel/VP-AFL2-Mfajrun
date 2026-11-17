import 'package:flutter/material.dart';
import '../domain/entities/todo_entity.dart';
import '../domain/repositories/todo_repository.dart';
import '../viewmodels/todo_form_viewmodel.dart';
import '../viewmodels/todo_list_viewmodel.dart';
import 'todo_form_screen.dart';
import 'widgets/empty_todo_view.dart';
import 'widgets/todo_app_header.dart';
import 'widgets/todo_item_tile.dart';
import 'widgets/todo_search_filter.dart';

class TodoListScreen extends StatefulWidget {
  final TodoListViewModel viewModel;
  final TodoRepository repository;

  const TodoListScreen({
    super.key,
    required this.viewModel,
    required this.repository,
  });

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadTodos();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToForm([Todo? todo]) async {
    final formViewModel = TodoFormViewModel(repository: widget.repository);
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => TodoFormScreen(
          viewModel: formViewModel,
          todoToEdit: todo,
        ),
      ),
    );

    if (result == true && mounted) {
      widget.viewModel.loadTodos();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(todo == null ? 'Tugas ditambahkan' : 'Tugas diperbarui'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final viewModel = widget.viewModel;
        final state = viewModel.state;

        return Scaffold(
          appBar: const TodoAppHeader(
            title: 'Daftar Tugas Saya',
          ),
          body: Column(
            children: [
              TodoSearchFilter(
                searchController: _searchController,
                currentFilter: viewModel.currentFilter,
                totalCount: viewModel.totalCount,
                activeCount: viewModel.activeCount,
                completedCount: viewModel.completedCount,
                onSearchChanged: (val) => viewModel.setSearchQuery(val),
                onSearchCleared: () {
                  _searchController.clear();
                  viewModel.setSearchQuery('');
                },
                onFilterSelected: (filter) => viewModel.setFilter(filter),
              ),
              Expanded(
                child: _buildStateContent(context, state, viewModel),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _navigateToForm(),
            icon: const Icon(Icons.add),
            label: const Text('Tambah Tugas'),
          ),
        );
      },
    );
  }

  Widget _buildStateContent(
    BuildContext context,
    TodoListState state,
    TodoListViewModel viewModel,
  ) {
    return switch (state) {
      TodoListLoading() || TodoListInitial() => const Center(
          child: CircularProgressIndicator(),
        ),
      TodoListError(message: final msg) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => viewModel.loadTodos(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      TodoListLoaded(todos: final todos) => todos.isEmpty
          ? EmptyTodoView(searchQuery: viewModel.searchQuery)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoItemTile(
                  todo: todo,
                  onToggle: (_) => viewModel.toggleTodoStatus(todo.id),
                  onEdit: () => _navigateToForm(todo),
                  onDelete: () {
                    viewModel.deleteTodo(todo.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tugas dihapus'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
    };
  }
}
