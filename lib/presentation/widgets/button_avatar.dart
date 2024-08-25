import 'package:flutter/material.dart';

class ButtonAvatar extends StatelessWidget {
  const ButtonAvatar({
    super.key,
    this.color,
     this.onTap,
     this.child,
  });

  final Widget? child;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color,
        child: child,
      ),
    );
  }
}
