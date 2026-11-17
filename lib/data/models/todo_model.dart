import '../../domain/entities/todo_entity.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.title,
    super.description = '',
    super.isCompleted = false,
    required super.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String? ?? '',
    isCompleted: json['isCompleted'] as bool? ?? false,
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : DateTime.now(),
  );

  factory TodoModel.fromEntity(Todo entity) => TodoModel(
    id: entity.id,
    title: entity.title,
    description: entity.description,
    isCompleted: entity.isCompleted,
    createdAt: entity.createdAt,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    'createdAt': createdAt.toIso8601String(),
  };
}