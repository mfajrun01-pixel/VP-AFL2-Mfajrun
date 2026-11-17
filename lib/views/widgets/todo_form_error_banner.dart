import 'package:flutter/material.dart';

class TodoFormErrorBanner extends StatelessWidget {
  final String errorMessage;

  const TodoFormErrorBanner({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade900),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.red.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
