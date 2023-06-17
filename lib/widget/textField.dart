import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const Textfield({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return TextField(
      controller: controller,
      style:  TextStyle(color: theme.colorScheme.primary ),
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
              fontSize: 15, color: theme.colorScheme.primary, fontWeight: FontWeight.normal),
        ),
        border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }
}
