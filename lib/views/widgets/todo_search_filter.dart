import 'package:flutter/material.dart';
import '../../viewmodels/todo_list_viewmodel.dart';

class TodoSearchFilter extends StatelessWidget {
  final TextEditingController searchController;
  final TodoFilter currentFilter;
  final int totalCount;
  final int activeCount;
  final int completedCount;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;
  final ValueChanged<TodoFilter> onFilterSelected;

  const TodoSearchFilter({
    super.key,
    required this.searchController,
    required this.currentFilter,
    required this.totalCount,
    required this.activeCount,
    required this.completedCount,
    required this.onSearchChanged,
    required this.onSearchCleared,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search tasks...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: onSearchCleared,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: Text('All ($totalCount)'),
                  selected: currentFilter == TodoFilter.all,
                  onSelected: (_) => onFilterSelected(TodoFilter.all),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Active ($activeCount)'),
                  selected: currentFilter == TodoFilter.active,
                  onSelected: (_) => onFilterSelected(TodoFilter.active),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: Text('Completed ($completedCount)'),
                  selected: currentFilter == TodoFilter.completed,
                  onSelected: (_) => onFilterSelected(TodoFilter.completed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
