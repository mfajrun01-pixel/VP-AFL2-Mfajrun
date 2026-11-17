import 'package:flutter/material.dart';

class TodoFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final bool autofocus;

  const TodoFormInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.validator,
    this.maxLines = 1,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
      ),
      validator: validator,
      maxLines: maxLines,
      autofocus: autofocus,
    );
  }
}
