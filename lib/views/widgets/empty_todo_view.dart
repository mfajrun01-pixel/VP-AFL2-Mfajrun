import 'package:flutter/material.dart';

class EmptyTodoView extends StatelessWidget {
  final String searchQuery;

  const EmptyTodoView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            searchQuery.isNotEmpty
                ? 'No tasks matching "$searchQuery"'
                : 'No tasks found. Tap + to add one!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
