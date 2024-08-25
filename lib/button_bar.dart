import 'package:flutter/material.dart';

class ButtonIconBar extends StatelessWidget {
  const ButtonIconBar({
    super.key,
    required this.icon,
    this.color,
    this.onTap,
  });

  final Widget icon;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: icon,
      color: color,
    );
  }
}
