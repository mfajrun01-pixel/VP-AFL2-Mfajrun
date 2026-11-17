import 'package:flutter/material.dart';
import '../domain/entities/todo_entity.dart';
import '../viewmodels/todo_form_viewmodel.dart';
import 'widgets/todo_app_header.dart';
import 'widgets/todo_form_error_banner.dart';
import 'widgets/todo_form_input_field.dart';
import 'widgets/todo_form_submit_button.dart';

class TodoFormScreen extends StatefulWidget {
  final TodoFormViewModel viewModel;
  final Todo? todoToEdit;

  const TodoFormScreen({
    super.key,
    required this.viewModel,
    this.todoToEdit,
  });

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  bool get isEditing => widget.todoToEdit != null;

  @override
  void initState() {
    super.initState();
    widget.viewModel.initWithTodo(widget.todoToEdit);
    _titleController = TextEditingController(text: widget.viewModel.title);
    _descriptionController =
        TextEditingController(text: widget.viewModel.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      widget.viewModel.setTitle(_titleController.text);
      widget.viewModel.setDescription(_descriptionController.text);

      final success = await widget.viewModel.saveForm(widget.todoToEdit);
      if (success && mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final viewModel = widget.viewModel;
        final state = viewModel.state;
        final isSaving = state is TodoFormSaving;
        final errorMessage = state is TodoFormError ? state.message : null;

        return Scaffold(
          appBar: TodoAppHeader(
            title: isEditing ? 'Edit Tugas' : 'Tugas Baru',
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (errorMessage != null) ...[
                    TodoFormErrorBanner(
                      errorMessage: errorMessage,
                    ),
                    const SizedBox(height: 16),
                  ],
                  TodoFormInputField(
                    controller: _titleController,
                    label: 'Judul Tugas *',
                    hint: 'Masukkan judul tugas',
                    prefixIcon: Icons.title,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Judul tugas tidak boleh kosong';
                      }
                      return null;
                    },
                    autofocus: !isEditing,
                  ),
                  const SizedBox(height: 16),
                  TodoFormInputField(
                    controller: _descriptionController,
                    label: 'Deskripsi (Opsional)',
                    hint: 'Masukkan detail tugas',
                    prefixIcon: Icons.description,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  TodoFormSubmitButton(
                    isEditing: isEditing,
                    isSaving: isSaving,
                    onPressed: _saveForm,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
