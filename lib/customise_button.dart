import 'package:flutter/material.dart';

class CustomiseButton extends StatelessWidget {
  const CustomiseButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });

  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        minimumSize: const Size(295, 36),
        backgroundColor: color,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
