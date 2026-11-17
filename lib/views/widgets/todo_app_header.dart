import 'package:flutter/material.dart';

class TodoAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;

  const TodoAppHeader({
    super.key,
    required this.title,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
