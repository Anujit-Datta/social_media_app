import 'package:flutter/material.dart';

class CustomizeBox extends StatelessWidget {
  const CustomizeBox({
    super.key,
     this.child,
    this.height,
    this.width,
    this.onTap,
    this.color,
  });

  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}