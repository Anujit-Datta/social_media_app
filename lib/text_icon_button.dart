import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    super.key,
    required this.title,
    required this.onTap, required this.color,
  });

  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        minimumSize: const Size(295, 36),
      ),
      onPressed: onTap,
      icon: Text(
        title,
        style:  TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
      label: const Icon(Icons.keyboard_arrow_down),
    );
  }
}