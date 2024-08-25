import 'package:flutter/material.dart';

class SelectedIconButton extends StatelessWidget {
  const SelectedIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            size: 60,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}