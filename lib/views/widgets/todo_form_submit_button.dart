import 'package:flutter/material.dart';

class TodoFormSubmitButton extends StatelessWidget {
  final bool isEditing;
  final bool isSaving;
  final VoidCallback? onPressed;

  const TodoFormSubmitButton({
    super.key,
    required this.isEditing,
    required this.isSaving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isSaving ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: isSaving
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(isEditing ? Icons.save : Icons.add_task),
      label: Text(
        isEditing ? 'Save Changes' : 'Create Task',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
